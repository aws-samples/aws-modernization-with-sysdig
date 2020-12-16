---
title: "Detecting Runtime Cloud Security Threats"
chapter: false
weight: 53
---

Let's look at an example of AWS threat detection in action with CloudTrail and the Sysdig CloudConnector.  To do so we'll create an S3 bucket, and make it public

1. Log into Cloud9 Workspace

      S3 bucket names are globally unique, so use **your initials** in **lower case** combined with a timestamp

2. First set your initials as an environment variable

    ```
    INITIALS=<your initials>
    ```

3. Now create the S3 bucket, ensuring the bucket name is in lowercase.

    ```
    BUCKETNAME="${INITIALS,,}"-$(date +%s)
    aws s3api create-bucket --bucket $BUCKETNAME --acl public-read
    ```

4. Now delete the S3 bucket's encryption.  This should be considered a potential security threat.

    ```
    aws s3api delete-bucket-encryption --bucket $BUCKETNAME
    ```

4. To view details of this event, browse to [CloudTrail](https://console.aws.amazon.com/cloudtrail/home) then 'Event History'

    ![CloudTrail](/images/50_module_3/cloudtrail01.png)

    If you scroll down you'll see details of the new CloudTrail event in JSON format:

5. Below is an example of a 'DeleteBucketEncryption' event raised after our previous command

{{% notice info %}}
It can take several minutes for new events to appear in CloudTrail. In the meantime you can browse the existing events created earlier from earlier activity in the account.
{{% /notice %}}

```
{
    "eventVersion": "1.05",
    "userIdentity": {
        "type": "AssumedRole",
        "principalId": "AROAVAOQCKJMIBOSOS7IM:i-08b251cf94d4e6a80",
        "arn": "arn:aws:sts::370614344560:assumed-role/Sysdig-Workshop-Admin/i-08d4e6ab251cf9480",
        "accountId": "344570614360",
        "accessKeyId": "ASIAVRLT4PAKJMFOQCMK",
        "sessionContext": {
            "sessionIssuer": {
                "type": "Role",
                "principalId": "ARQCKJMIBOSOS7OAVAOIM",
                "arn": "arn:aws:iam::370614344560:role/Sysdig-Workshop-Admin",
                "accountId": "370614344560",
                "userName": "Sysdig-Workshop-Admin"
            },
            "webIdFederationData": {},
            "attributes": {
                "mfaAuthenticated": "false",
                "creationDate": "2020-12-16T10:37:43Z"
            },
            "ec2RoleDelivery": "2.0"
        }
    },
    "eventTime": "2020-12-16T11:02:06Z",
    "eventSource": "s3.amazonaws.com",
    "eventName": "DeleteBucketEncryption",
    "awsRegion": "us-east-1",
    "sourceIPAddress": "54.208.132.231",
    "userAgent": "[aws-cli/1.18.197 Python/3.6.12 Linux/4.14.203-116.332.amzn1.x86_64 botocore/1.19.37]",
    "requestParameters": {
        "bucketName": "in-1608116489",
        "Host": "in-1608116489.s3.amazonaws.com",
        "encryption": ""
    },
    "responseElements": null,
    "additionalEventData": {
        "SignatureVersion": "SigV4",
        "CipherSuite": "ECDHE-RSA-AES128-GCM-SHA256",
        "bytesTransferredIn": 0,
        "AuthenticationMethod": "AuthHeader",
        "x-amz-id-2": "7oxWqk04DWgmjvSO3TgutyZPtcOYIfnJud2SGZEQOryG3LNgpSV9ZYCd4jLqatr9VaGMEefUVKg=",
        "bytesTransferredOut": 0
    },
    "requestID": "E90DD548B6C5B224",
    "eventID": "af6a54f9-c2ee-4e14-866a-48f9338bcc94",
    "readOnly": false,
    "resources": [
        {
            "accountId": "370614344560",
            "type": "AWS::S3::Bucket",
            "ARN": "arn:aws:s3:::in-1608116489"
        }
    ],
    "eventType": "AwsApiCall",
    "recipientAccountId": "370614344560"
}
```

{{% notice info %}}
Please note that all data in the JSON doc above is fictitious and is used as an example.
{{% /notice %}}


All CloudTrail events have the following key fields:

- **userIdentity**: The user who sent the request.
- **eventName**: Specifies the type of event.
- **requestParameters**: Contains all of the parameters related to the request.

If a request has an **errorCode** field, it means that it could not be processed because of an error. For example, the requester may not have had permission to perform a change.

In this case, we can see encryption hs been deleted (**DeleteBucketEncryption**) by user with administrator access (**arn:aws:iam::370614344560:role/Sysdig-Workshop-Admin**).

<!-- In this case, we can see how a policy has just been attached (**AttachUserPolicy**) to a user (**admin_test**) with administrator access (**arn:aws:iam::aws:policy/AdministratorAccess**). -->

A Falco rule to detect this elevation of privileges would look like this:


```
- rule: Delete bucket encryption
  desc: Detect deleting configuration to use encryption for bucket storage
  condition: >
    jevt.value[/eventName]="DeleteBucketEncryption" and not jevt.value[/errorCode] exists
  output: >
    An encryption configuration for a bucket has been deleted
    (requesting user=%jevt.value[/userIdentity/arn],
     requesting IP=%jevt.value[/sourceIPAddress],
     AWS region=%jevt.value[/awsRegion],
     bucket=%jevt.value[/requestParameters/bucketName])
  priority: CRITICAL
  tags: [cloud, source=cloudtrail, aws, NIST800_53, NIST800_53_AU8]
  source: k8s_audit
```

Some points to note about this rule:

 - The **jevt.value** contains the JSON content of the event, and we are using it in the **condition**. Using the [jsonpath](https://jsonpath.com/) format, we can indicate what parts of the event we want to evaluate.

 - The **output** will provide context information including the requester **username** and **IP address** - this is what will be sent through all of the enabled notification channels.

As you can see, this is a regular Falco rule. In fact, this particular rule is already included out-of-the-box in Sysdig CloudConnector. CloudTrail compatibility is achieved by handling its events as JSON objects, and referring to the event information using JSONPath.
