
+++
title = "CloudFormation-based"
chapter = true
weight = 2
+++

## Connect your Cloud Account

The next steps will deploy Sysdig Secure for cloud using AWS CloudFormation. To connect your cloud account to Sysdig and deploy the CF Template:

1. Log into Sysdig Secure, and browse to **Getting Started**, then **Connect your Cloud Account**, then click **Launch Stack**

    ![Connect your Cloud Account](/images/Get_Started.png)

    **Note:** Make sure you switch to your desired AWS region for deployment of the associated resources.  For the purposes of the workshop, make sure you're in US-East (i.e. 'N. Virginia').

    The AWS Console should open the CF Template

    <!-- [Sysdig Secure for cloud CloudFormation template](https://console.aws.amazon.com/cloudformation/home?#/stacks/quickCreate?stackName=Sysdig-CloudVision&templateURL=https://cf-templates-cloudvision-ci.s3-eu-west-1.amazonaws.com/master/entry-point.yaml) -->

    ![Cloud Security CloudFormation Stack](/images/CloudSecurityCloudFormationStack-with-notes2.png)

    Mandatory parameters are:

    - **Stack Name**: You can leave this as its default 'Sysdig-CloudVision'

    - **Sysdig Secure Endpoint**: Enter the value in your Sysdig Secure domain name, i.e. one of the following

          - `https://secure.sysdig.com`

          - `https://eu1.app.sysdig.com`

          - `https://us2.app.sysdig.com`

            Remember to include `https://` at the beginning, and no trailing slash at the end.

    -  **Sysdig Secure API Token**: enter your 'Sysdig Secure API Token' for your Sysdig Secure account. You can find this in your Sysdig Secure User Profile.

          <!-- You can find this in your Sysdig Secure User Profile (**Note** Please make sure you logged into Sysdig Secure, and not Sysdig Monitor). ![API token](/images/30_module_1/sysdig_api_01.png) -->

    <!-- - **Sysdig Agent Key**: _Paste your Sysdig Secure Agent key_    -->

    - **Modules to Deploy**: For the purposes of this lab, please make sure all options are selected.


2. Make sure to check the two tick boxes at the end

    - ✅ **I acknowledge that AWS CloudFormation might create IAM resources with custom names**.

    - ✅ **I acknowledge that AWS CloudFormation might require the following capability: CAPABILITY_AUTO_EXPAND**

        The first of these is required to create the IAM roles for the new resources, and the second is to execute sub-templates that this template incorporates for the different features of Sysdig Secure for cloud.

3. Click **Create stack**

4. Wait until the installation finishes

    You will first see the stack "Sysdig-CloudVision" in "CREATE_IN_PROGRESS" state. It will also start to create 7 sub-stacks associated with the main one. When you refresh the status of the template and it shows "CREATE_COMPLETE" for all of them, the installation is finished.

    ![Create complete](/images/cloudsec-site/cloudformation/installation/installation_complete.png)


## Cleanup

Should you wish to uninstall Sysdig Secure for cloud from your account, then follow the steps below.

{{% notice warning %}}
Uninstalling Sysdig Secure for cloud is **not** part of this workshop (just when the workshop ends), so only follow the steps below if required to do so.
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

2. Remove Amazon Integration CloudFormation stack

    ```
    aws cloudformation delete-stack --stack-name Sysdig-CloudVision
    ```
