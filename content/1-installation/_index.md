
+++
title = "1. Installation"
chapter = true
weight = 20
+++

*Estimated duration: less than 5 minutes.*

# Module 1: Installation

<!-- There are two steps in setting up **Sysdig Secure for cloud** in AWS -->

**Sysdig Secure for cloud** is provisioned in AWS by simply deploying a CloudFormation Template. This single CloudFormation Template will deploy

 - Cloud Security Posture Management and Compliance
 - Threat Investigation based on CloudTrail
 - ECR Image Registry Scanning
 - Fargate Image Scanning


As part of this deployment process you will need to provide your

 - Sysdig Secure API Token
 - Sysdig Secure API Endpoint

If you do not have a Sysdig account, then you can follow the steps [here](/0-prerequisites/2-sysdig_account.html) to create a free trial Sysdig Account.

Once you have these you can continue to deploy the Sysdig Secure for cloud CloudFormation Template

<!--
## Create a Sysdig Trial Account

You need a Sysdig Secure account to complete this workshop. In particular you will need to make a note of your account's associated API token & API Endpoint to configure the integrations.

1. Sign-up for a free Sysdig trial here [https://sysdig.com/company/free-trial/?utm_campaign=aws-workshop ](https://sysdig.com/company/free-trial/?utm_campaign=aws-workshop). Remember to **select Sysdig Secure** under the *Trial Offer...* dropdown.

    - You will receive a confirmation email with a confirmation link

2. Click the link and log into Sysdig, and make a note of the following two items (see animated GIF below for details on how to obtain these two values)

 - The '**Sysdig Secure API Endpoint**' you are routed to.  This will be the Sysdig Secure hostname in the browser URL. It should be one of the following
     - https://secure.sysdig.com
     - https://eu1.app.sysdig.com
     - https://us2.app.sysdig.com

         Make sure you do not leave a trailing `/` in this URL. For more information of Sysdig's regional URLs, please refer to the [Sysdig documentation](https://docs.sysdig.com/en/saas-regions-and-ip-ranges.html).

 - Your '**Sysdig Secure API Token**'. Click your initials on the left nav bar, click '**Settings**' and navigate to '**User Profile**'.

        **IMPORTANT:** Make sure you **DO NOT** use the **Sysdig Monitor** API Token, or the Access Token!


<img src=/images/10_prerequisites/apiValues.gif width="100%" > -->
