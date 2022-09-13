---
title: "Detecting Runtime Cloud Security Threats"
chapter: false
weight: 2
---


Let's look at an example of AWS threat detection in action with CloudTrail and the Sysdig Secure for Cloud.  We want to generate an event to trigger the **"Delete Bucket Encryption"** rule from the **"Sysdig AWS Notable Events"** policy.

The first part is to be able to generate the suspicious event from the AWS side. To do so we'll create an S3 bucket, and make it public.

S3 bucket names are globally unique, so we'll use **your initials** in **lower case** combined with a timestamp to formoudtrailssdsss the bucket name.

1. Log into Cloud9 Workspace, and set your initials as an environment variable

    ```
    INITIALS=<your initials>
    ```

1. Now create the S3 bucket, ensuring the bucket name is in lowercase.

    ```
    BUCKETNAME="${INITIALS,,}"-$(date +%s)
    aws s3api create-bucket --bucket $BUCKETNAME --acl public-read
    ```

1. Now delete the S3 bucket's encryption.  This should be considered a potential security threat.

    ```
    aws s3api delete-bucket-encryption --bucket $BUCKETNAME
    ```

1. You can view details of this event by browsing to [CloudTrail](https://console.aws.amazon.com/cloudtrail/home) then 'Event History'

    ![CloudTrail](/images/cloudtrail03.png)

    **NOTE** It can take several minutes for new events to appear in CloudTrail. In the meantime you can browse the existing events created earlier from earlier activity in the account.

    If you scroll down you'll see details of the new CloudTrail event in JSON format:

    ![CloudTrail](/images/cloudtrail_json03.png)

    All CloudTrail events have the following key fields:

      - **userIdentity**: The user who sent the request.
      - **eventName**: Specifies the type of event.
      - **requestParameters**: Contains all of the parameters related to the request.


The Falco rule should have triggered creating an event in Sysdig Secure, so we'll look at that next.
