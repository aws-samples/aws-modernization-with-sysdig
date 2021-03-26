---
title: "Deploy CloudFormation Template"
chapter: false
weight: 22
---

### Connect your Cloud Account

Sysdig Secure for cloud is deployed using AWS CloudFormation.  To connect your cloud account to Sysdig and deploy the CF Template,

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


1. Make sure to check the two tick boxes at the end

    - ✅ **I acknowledge that AWS CloudFormation might create IAM resources with custom names**.

    - ✅ **I acknowledge that AWS CloudFormation might require the following capability: CAPABILITY_AUTO_EXPAND**

        The first of these is required to create the IAM roles for the new resources, and the second is to execute sub-templates that this template incorporates for the different features of Sysdig Secure for cloud.

1. Click **Create stack**

### Wait until the installation finishes

You will first see the stack "Sysdig-CloudVision" in "CREATE_IN_PROGRESS" state. It will also start to create 7 sub-stacks associated with the main one. When you refresh the status of the template and it shows "CREATE_COMPLETE" for all of them, the installation is finished.

<!-- Amazon starts sending runtime events approximately 10 minutes after you first create a CloudTrail trail.  However, although there is an initial delay on seeing these come through, no event is lost. -->


![Create complete](/images/cloudsec-site/cloudformation/installation/installation_complete.png)

Once the CF Template has successfully deployed, you can continue with the workshop.
