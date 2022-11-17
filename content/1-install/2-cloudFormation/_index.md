---
title: "Cloud: CloudFormation-based"
chapter: true
weight: 2
---

{{% notice info %}}
*Estimated sub-module duration: 5-10 minutes.*
{{% /notice %}}

{{% notice note %}}
Don't follow this steps if you already installed Sysdig Secure for Cloud with Terraform
in the previous step.
{{% /notice %}}


## Requirements

There are no requirements for this method.


## Install

1. Log into Sysdig Secure, and browse to **Integrations > Data Sources > Cloud Accounts**, 
then [**Connect Cloud Account > AWS > Cloud Formation Template**](https://secure.sysdig.com/#/data-sources/cloud-accounts?setupModalEnv=AWS&installContentDisplayType=tabular&accountType=cft).

    ![Install with Terraform](/images/1-installation/aws-cft.png)

    {{% notice note %}}
Make sure you switch to your desired AWS region for deployment of the associated resources.
For the purposes of the workshop, make sure you're in `us-east-1` (i.e. 'N. Virginia').
{{% /notice %}}

    The AWS Console should open the CF Template

    <!-- [Sysdig Secure for cloud CloudFormation template](https://console.aws.amazon.com/cloudformation/home?#/stacks/quickCreate?stackName=Sysdig-CloudVision&templateURL=https://cf-templates-cloudvision-ci.s3-eu-west-1.amazonaws.com/master/entry-point.yaml) -->

    ![Cloud Security CloudFormation Stack](/images/CloudSecurityCloudFormationStack-with-notes2.png)

    Mandatory parameters are:

    - **Stack Name**: You can leave this as its default 'Sysdig-CloudVision'

    - **Sysdig Secure Endpoint**: Enter the value in your Sysdig Secure domain name, 
        i.e. one of the following: `https://secure.sysdig.com`, `https://eu1.app.sysdig.com`,`https://us2.app.sysdig.com`.
        
        In case of doubt, visit the documentation page of
        [Sysdig Regions](https://docs.sysdig.com/en/docs/administration/saas-regions-and-ip-ranges/) to learn more about it.

        Remember to include `https://` at the beginning, and no trailing slash at the end.

    -  **Sysdig Secure API Token**: enter your 'Sysdig Secure API Token' for your Sysdig Secure account.

    - **Modules to Deploy**: For the purposes of this lab, please make sure all options are selected.


2. Make sure to check the two tick boxes at the end

    - ✅ **I acknowledge that AWS CloudFormation might create IAM resources with custom names**.

    - ✅ **I acknowledge that AWS CloudFormation might require the following capability: CAPABILITY_AUTO_EXPAND**

        The first of these is required to create the IAM roles for the new resources,
        and the second is to execute sub-templates that this template incorporates
        for the different features of Sysdig Secure for cloud.

3. Click **Create stack**

4. Wait until the installation finishes

    You will first see the stack "Sysdig-CloudVision" in *CREATE_IN_PROGRESS* state.
    It will also start to create 7 *sub-stacks* associated with the main one.
    When you refresh the status of the template and it shows *CREATE_COMPLETE* for all of them,
    the installation is finished.

    ![Create complete](/images/cloudsec-site/cloudformation/installation/installation_complete.png)


## Review accounts connected

There are [different methods](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-aws/#confirm-the-services-are-working) to check that the installation was successful. 

Visit the Data Sources [**Data Sources > Cloud Accounts**](https://secure.sysdig.com/#/data-sources/cloud-accounts)
to review that an account with your Account ID is connected.

![Cloud Account Connected](/images/1-installation/cloudaccountsconnected.png)