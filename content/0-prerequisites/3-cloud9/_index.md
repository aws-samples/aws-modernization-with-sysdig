---
title: "Cloud9 Workspace"
chapter: true
weight: 3
---

[AWS Cloud9](https://aws.amazon.com/cloud9/) is a cloud-based integrated development environment (IDE)
that lets you write, run, and debug your code from anywhere with just a browser.
It includes a code editor, debugger, and terminal. Cloud9 comes prepackaged with essential tools for popular programming languages.

You will use _Amazon Cloud9_ to access our AWS account via the AWS CLI in this Workshop. There are a few steps to complete to set this up

1. Create and configure a new Cloud9 IDE environment
2. Configure Cloud9 IDE environment
3. Create and attach an IAM role for your workspace
4. Configure workshop specific requirements


## Create a new Cloud9 IDE environment

To access a Cloud9 instance, networking is required.
Create a VPC for the Cloud9 instance. Follow this link to
[**create VPC**](https://us-east-1.console.aws.amazon.com/vpc/home?region=us-east-1#CreateVpc:createMode=vpcWithResources),
select **VPC and More** 
and click on **Create VPC** to generate the networking components.

Then, to create and confiure the Cloud9 instance for this workshop:

1. [Follow this link](https://us-east-1.console.aws.amazon.com/cloud9control/home?region=us-east-1#/create/)
   to create the IDE. Name it `sysdig-workshop`.

2. Select the options:
    - *Instance type*: **t3.medium**.
    - *Platform*: **Amazon Linux 2**.
    - *Connection*: **Secure Shell (SSH)**.

3. Expand **VPC settings** under **Network settings** and check that the VPC created above
   and one of the subnets are selected.
   Click **Create** and then open the new workstation.

    ![Deploy Cloud9](/images/10_prerequisites/cloud9.gif)

    {{% notice info %}}
Wait for it to be ready. This might take up to 1-2 minutes to provision.
{{% /notice %}}


## Configure Cloud9 IDE environment

When the environment comes up, customize the environment by:

  - Closing the **welcome page** tab.
  - Closing the **lower work area** tab.
  - Opening a new **terminal** tab in the main work area.
  - Hiding the left hand environment explorer
   by clicking on the left side **environment** tab.

    ![Deploy Cloud9](/images/10_prerequisites/cloud9config.gif)


    {{% notice tip %}}
Cloud9 requires third-party-cookies. You can whitelist the [specific domains]( https://docs.aws.amazon.com/cloud9/latest/user-guide/troubleshooting.html#troubleshooting-env-loading).  You are having issues with this, Ad blockers, javascript disablers, and tracking blockers should be disabled for the cloud9 domain, or connecting to the workspace might be impacted.
{{% /notice %}}


## Set persmissions for your workspace

{{% notice info %}}
Cloud9 normally manages IAM credentials dynamically. This isn't currently compatible with
the EKS IAM authentication, so we will disable it and rely on the IAM role instead.
{{% /notice %}}

Follow the next steps to create the IAM role for the Cloud9 machine
and attach the new role to it.

1. Click the gear icon (in top right corner),
   and select **AWS SETTINGS**. Turn off **AWS managed temporary credentials** and close the Preferences tab.
   
   ![image](/images/10_prerequisites/iamRoleWorkspace.gif)

2. Follow [this deep link to create an IAM role with Administrator access.](https://console.aws.amazon.com/iam/home#/roles$new?step=review&commonUseCase=EC2%2BEC2&selectedUseCase=EC2&policies=arn:aws:iam::aws:policy%2FAdministratorAccess)
   
3. Confirm that **AWS service** and **EC2** are selected,
   then click **Next: Permissions**. Check **AdministratorAccess**,
   then click **Next: Tags** and **Next: Review** to get to the last step.

   Name the role: `Sysdig-Workshop-Admin` and select **Create role**.
   In the next step you'll assign it to the machine.

    ![Create IAM Role](/images/10_prerequisites/iamRole.gif)


3. Follow [this deep link to find your Cloud9 EC2 instance](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:search=aws-cloud9-sysdig;sort=desc:launchTime).

   Select the existing instance, then choose **Actions > Security > Modify IAM role**.
   Choose the new role **Sysdig-Workshop-Admin** from the drop down, and click on **Update IAM role**.

   ![Attach IAM Role](/images/10_prerequisites/attachIAMRole.gif)


## Workshop-specific requirements

Your workstation is ready to start the workshop.Starting from here, when you see command to be entered such as below, you will enter these commands into *Cloud9 IDE* or equivalent terminal of your choice.

1. Clone the workshop repository and get the provided files and execute the script to setup the general requirements for the workshop:

   ```bash
   git clone https://github.com/sysdiglabs/aws-modernization-with-sysdig
   cp aws-modernization-with-sysdig/static/code ./
   ./ws_general_requirements.sh
   ```

   {{% notice warning %}}
This script will check the status of the attached IAM role: if it is not valid, <span style="color: red;">**DO NOT PROCEED**</span>. Go back and confirm the steps on this page.
{{% /notice %}}

1. If you are going to run the Runtime Security and Actionable Compliance modules for EKS, 
   launch a new EKS cluster with the next command.
   (The EKS cluster deployment in AWS will take about 10 minutes to complete).

   ```bash
   ./create_eks.sh
   ```

   There's no need to wait until the EKS provisioner is done. Open a new Terminal and continue from there with the workshop until the script is done.