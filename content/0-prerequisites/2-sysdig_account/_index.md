---
title: "Sysdig Secure Account"
chapter: false
weight: 1
---

You need a Sysdig Secure account with administration access to complete this workshop.
During the next steps you'll be required to retrieve and use some user data like:
- Sysdig Secure API token
- Sysdig Secure API endpoint
- Agent Access key

During the workshop, you'll get instructions to learn how to get them.


{{% notice info %}}
**About Sysdig and AWS regions**:
For production, having your Sysdig Saas account in a region close to you AWS region
is beneficial, but for this training you can select the region you want.
Learn more about Sysdig Saas regions in the
[docs](https://docs.sysdig.com/en/docs/administration/saas-regions-and-ip-ranges/).
{{% /notice %}}

## Getting a new account

In case you don't have an account yet, follow the next steps:

1. Sign-up for a free Sysdig trial here:
   [https://sysdig.com/company/free-trial/?utm_campaign=aws-workshop ](https://sysdig.com/company/free-trial/?utm_campaign=aws-workshop).
   **Select all of the options** available.

    ![Get trial](/images/10_prerequisites/getTrial.png)

2. You will receive a confirmation email.
   Follow the link to log into Sysdig in a new tab.

3. Set a password, and the onboarding Wizard will be presented (the next steps are going to skip the Wizard,
   you'll be learning in the next steps how to install all required Sysdig components in your AWS account and EKS cluster).
   Select AWS and then click on `Alternatively, provision with Terraform for Single Account`.

    ![Onboarding](/images/onboarding.png)

4. Type in the AWS Region `us-east-1` and click `Next`.
   Then click `Get into Sysdig`. The Sysdig Secure UI will be presented.

   In the next step, you'll setup an AWS Cloud9 engine as a workstation to complete this workshop.
