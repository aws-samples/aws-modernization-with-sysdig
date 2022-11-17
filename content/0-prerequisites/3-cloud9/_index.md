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
2. Create and attach an IAM role for your workspace
3. Configure workshop specific requirements


## Create a new Cloud9 IDE environment

1. Navigate to the [cloud9 console](https://console.aws.amazon.com/cloud9/home)
   or just search for it under the **AWS console services** menu.

2. Click the **Create environment** button
   and name it  `sysdig-workshop`. Then click **Next step**.

3. Select the default instance type: **t3.medium**.

4. Expand **Network settings (Advanced)** and under **Subnet**,
   select a subnet in **us-east-1a** availability zone.

5. Leave all the other settings as default
   and click **Next step** followed by **Create environment**.

    ![Deploy Cloud9](/images/10_prerequisites/cloud9.gif)

    {{% notice info %}}
This will take about 1-2 minutes to provision
{{% /notice %}}


## Configure Cloud9 IDE environment

When the environment comes up, customize the environment by:

1. Closing the **welcome page** tab.
2. Closing the **lower work area** tab.
3. Opening a new **terminal** tab in the main work area.
4. Hiding the left hand environment explorer
   by clicking on the left side **environment** tab.

    ![Deploy Cloud9](/images/10_prerequisites/cloud9config.gif)

    {{% notice tip %}}
Cloud9 requires third-party-cookies. You can whitelist the [specific domains]( https://docs.aws.amazon.com/cloud9/latest/user-guide/troubleshooting.html#troubleshooting-env-loading).  You are having issues with this, Ad blockers, javascript disablers, and tracking blockers should be disabled for the cloud9 domain, or connecting to the workspace might be impacted.
{{% /notice %}}