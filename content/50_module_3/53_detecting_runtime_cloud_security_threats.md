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

![insertexamplejson]

{{% notice info %}}
Please note that all data in the JSON doc above is fictitious and is used as an example.
{{% /notice %}}


All CloudTrail events have the following key fields:

- **userIdentity**: The user who sent the request.
- **eventName**: Specifies the type of event.
- **requestParameters**: Contains all of the parameters related to the request.

If a request has an **errorCode** field, it means that it could not be processed because of an error. For example, the requester may not have had permission to perform a change.

In this case, we can see how a policy has just been attached (**AttachUserPolicy**) to a user (**admin_test**) with administrator access (**arn:aws:iam::aws:policy/AdministratorAccess**).

A Falco rule to detect this elevation of privileges would look like this:


```
- rule: Delete bucket encryption
  desc: Detect deleting configuration to use encryption for bucket storage
  condition: >
    jevt.value[/eventName]="DeleteBucketEncryption" and not jevt.value[/errorCode] exists
  output: >
    A encryption configuration for a bucket has been deleted
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
