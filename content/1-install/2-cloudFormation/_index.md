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

There are no requirements for this installer method.


## Install

1. Log into Sysdig Secure, and browse to **Integrations > Data Sources > Cloud Accounts**, 
then click on [**Connect Cloud Account > AWS > Cloud Formation Template**](https://secure.sysdig.com/#/data-sources/cloud-accounts?setupModalEnv=AWS&installContentDisplayType=tabular&accountType=cft).

1. Insert the **AWS Account ID** of the account you'd like to connect, name the **IAM** Role for Sysdig to access the required AWS resources and select **Deploy on ECS compute workload**. 
   
   Then, copy the *Sysdig Secure API Token* and click on **Launch Stack**.


    ![Install with Terraform](/images/1-installation/aws-cft.png)

    {{% notice note %}}
Make sure you switch to your desired AWS region for deployment of the associated resources.
For the purposes of the workshop, make sure you're in `us-east-1` (i.e. 'N. Virginia').
{{% /notice %}}

    The AWS Console should open the CF Template:

    1. Paste the *Sysdig Secure API Token*.

    ![Cloud Security CloudFormation Stack](/images/CloudSecurityCloudFormationStack-with-notes2.png)

    2. Select to deploy all available modules.

    3. Make sure to check the two tick boxes at the end.
        And click **Create stack**.
        You will first see the stack "Sysdig-CloudVision" in *CREATE_IN_PROGRESS* state.
        It will also start to create 7 *sub-stacks* associated with the main one.
        Wait until the installation finishes.

        ![Create complete](/images/cloudsec-site/cloudformation/installation/installation_complete.png)

Once completed, jump onto the [next section](/1-install/3-cloudreviewaccounts.html)
to learn how to check that the installation was successful, v.
