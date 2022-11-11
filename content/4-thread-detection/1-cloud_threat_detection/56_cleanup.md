---
title: "Cleanup"
chapter: false
weight: 6
---

1. Delete the log group created to test the Falco rule modification

    ```
    aws logs delete-log-group --log-group-name "test_unused_region" --region="us-west-2"
    ```

1. Delete an S3 bucket

    ```
    aws s3api delete-bucket --bucket $BUCKETNAME
    ```

1. Remove Sysdig Secure for Cloud Integration (CloudVision) in case you want to get rid of it

    ```
    aws cloudformation delete-stack --stack-name CloudConnector
    ```
