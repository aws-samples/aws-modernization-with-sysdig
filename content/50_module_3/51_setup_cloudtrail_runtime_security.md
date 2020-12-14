---
title: "Setup CloudTrail Runtime Security"
chapter: false
weight: 51
---

There are two steps required to enable CloudTrail runtime security:

1. Firstly, you must enable AWS Security Hub in the account, then
2. Deploy the Sysdig CloudConnector CloudFormation template.


{{% notice tip %}}
If you prefer learning by watching over reading, you can find an animated image at the bottom with all the steps listed below.
{{% /notice %}}

## Step 1. Enable AWS Security Hub

To enable AWS Security Hub:

1. Log into your Cloud9 Workspace

2. Run the following command (no output will be generated)

	    aws securityhub enable-security-hub --enable-default-standards

3. Log into your AWS account and browse to the [AWS Security Hub](https://console.aws.amazon.com/securityhub/home).

	If you see the Summary web page, it means its enabled in your account. You can skip to the **Step2** below.

{{% notice warning %}}
You may see a temporary red warning about AWS Config not being appropriately enabled, but it will disappear on its own once the Security Hub detects that the activation has been made. It has no relation to the use of Sysdig CloudConnector.
{{% /notice %}}

<img src=/images/20_workshop_setup/config.png width="75%" >
<!-- ![config_warning](/images/20_workshop_setup/config.png) -->

<!-- @pablo, I've never encountered this and cannot reproduce it, so I'm going to comment it out for now

**3.1. ALTERNATIVE 1. Not previously enabled**

If you see this _“Get started with Security Hub”_ page below, then click '**Go to Security Hub**'. (It means you never enabled it before). <img src=/images/20_workshop_setup/security_hub2.png width="75%" >
Then, click '**Enable Security Hub**'. After this, the _"Summary"_ page for Security Hub will be shown.

{{% notice note %}}
In the _"Welcome to AWS Security Hub"_ page, you can indicate which security standard controls you want to enable, or accept the default.
These controls are part of the default AWS Security Hub mechanism, and they are not related to the detections that Sysdig CloudConnector is going to find for you.
{{% /notice %}} -->

<!-- **3.2. ALTERNATIVE 2. Already enabled**

However, if you see the Summary web page, it means that you enabled it before in your account. You can skip to the **Step2** below. -->

## Step 2. Install the CloudConnector
Follow the steps below to install the Sysdig CloudConnector using a CloudFormation Template:

1. Navigate to the [CloudFormation template for Sysdig CloudConnector deployment](https://console.aws.amazon.com/cloudformation/home#/stacks/create/template?stackName=CloudConnector&templateURL=https://cf-templates-cloud-connector.s3.amazonaws.com/cloud-connector-aws-workshop.template).  The template will preview in CloudFormation.
<!-- ![cf1](/images/20_workshop_setup/cf1.png) -->

2. On the “**Create stack**” section, click the '**Next**' button to start setting up the template.
<!-- ![cf2](/images/20_workshop_setup/cf2.png) -->

3. The _“Specify stack details”_ section has no parameters for you to configure, so you can just press the **Next** button.
<!-- ![cf3](/images/20_workshop_setup/cf3.png) -->

4. On _“Configure stack options”_ screen, press the **Next** button.

	{{% notice note %}}
You can optionally add tag keys and values to the deployment, but no further configuration is required.
	{{% /notice %}}

	<!-- ![cf4](/images/20_workshop_setup/cf4.png) -->

    You will be presented with a summary of all the parameters you previously introduced. Please note that dedicated IAM roles will be created to perform the scanning. These roles follow the "least privilege principle" to enforce maximum security.

5. Finally click the checkbox

	![cf5](/images/20_workshop_setup/cf5.png)

6. Then press the **Create stack** button

<!-- DevNote: Update this screenshot to have consistent arrow -->

## All ready!

On the CloudFormation dashboard, you should see the template status is 'CREATE_IN_PROGRESS'.

<!-- ![cf6](/images/20_workshop_setup/cf6.png) -->

The creation process may take **up to ten minutes**.  It will show as “CREATE_COMPLETE” once the deployment has completed successfully.

![cf7](/images/20_workshop_setup/cf72.png)

<!-- You'll be using *CloudConnector* in Module 3. So, in the meantime, you can continue with this workshop. You can later revisit the *CloudFormation* section in AWS to check the status of the deployment.  -->

## Step summary

<img src=/images/module3prework.gif width="100%" >

<!-- To check it has been deployed successfully, navigate to  [https://console.aws.amazon.com/cloudformation/](https://console.aws.amazon.com/cloudformation/) and search for CloudConnector. You should see it's status is **CREATE_COMPLETE**.

![CloudTrail](/images/50_module_3/image3.png "image_tooltip") -->
