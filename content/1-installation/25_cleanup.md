---
title: "Cleanup"
chapter: false
weight: 25
---

Should you wish to uninstall Sysdig Secure for cloud from your account, then follow the steps below.

{{% notice warning %}}
Uninstalling Sysdig Secure for cloud is **not** part of this workshop, so only follow the steps below if required to do so.
{{% /notice %}}

1. Remove S3 buckets & versioned contents

    ```
    for BUCKET in $(aws s3 ls |grep cloudvision | awk '{print $3}') ; do
      aws s3 rm  --recursive s3://$BUCKET

      # Delete bucket versions      
      for VERSIONID in $(aws s3api list-object-versions --bucket $BUCKET --query Versions[].VersionId --output text) ; do
        MARKER=$(aws s3api list-object-versions --bucket $BUCKET --query 'Versions[?VersionId=='"'$VERSIONID'"'].Key' --output text)
        echo Deleting $MARKER $VERSIONID from $BUCKET
        aws s3api delete-object  --bucket $BUCKET --key $MARKER --version-id $VERSIONID
      done

      # Now delete DeleteMarkers      
      for VERSIONID in $(aws s3api list-object-versions --bucket $BUCKET --query DeleteMarkers[].VersionId --output text) ; do
        MARKER=$(aws s3api list-object-versions --bucket $BUCKET --query 'DeleteMarkers[?VersionId=='"'$VERSIONID'"'].Key' --output text)
        echo Deleting $MARKER $VERSIONID from $BUCKET
        aws s3api delete-object  --bucket $BUCKET --key $MARKER --version-id $VERSIONID
      done

      echo Deleting bucket $BUCKET
      aws s3api delete-bucket --bucket $BUCKET
    done
    ```


1. Remove Amazon Integration CloudFormation stack

    ```
    aws cloudformation delete-stack --stack-name Sysdig-CloudVision
    ```
