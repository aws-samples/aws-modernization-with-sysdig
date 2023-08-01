---
title: "Cloud: CloudFormation-based"
chapter: true
weight: 2
---

{{% notice note %}}
Don't follow this steps if you already installed Sysdig Secure for Cloud with Terraform
in the previous step.
{{% /notice %}}


## Requirements

There are no requirements for this installer method.


## Install

1. In the previous step we chosen AWS CloudFormation Template installation from the onboarding wizard.
(If you skipped the wizard, just log into Sysdig Secure and browse to **Integrations > Data Sources > Cloud Accounts**, 
then click on **Connect Account > AWS** Mark all options **Next** Mark "Single" **Next** AWS CloudFormation Template ). 
Insert the **AWS Account ID** of the account you'd like to connect and click on **Launch Stack**.


    ![Install with Terraform](/images/1-installation/aws-cft-onboarding.png)

    {{% notice note %}}
Make sure you switch to your desired AWS region for deployment of the associated resources.
For the purposes of the workshop, make sure you're in `us-east-1` (i.e. 'N. Virginia').
{{% /notice %}}

    The AWS Console should open the CF Template:

    1. Paste the *Sysdig Secure API Token*.
       From the screenshot below: 
       A. Change the "Stack name" string if you want a different name.
       B. Check tick boxes from the footer (acknowledge)

    ![Cloud Security CloudFormation Stack](/images/CloudSecurityCloudFormationStack-with-notes2.png)

    2.  Click **Create stack**.
        You will first see the stack "Sysdig-Secure" in *CREATE_IN_PROGRESS* state.
        It will also start to create *sub-stacks* associated with the main one.
        Wait until the installation finishes.

        ![Create complete](/images/cloudsec-site/cloudformation/installation/installation_complete.png)

Once completed, jump onto the [next section](/1-install/3-cloudreviewaccounts.html)
to learn how to check that the installation was successful, go to [Cloud Accounts Intall check](/1-install/3-cloudreviewaccounts.html) section
