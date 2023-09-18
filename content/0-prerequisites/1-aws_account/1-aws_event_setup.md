---
title: "AWS hosted event"
chapter: false
weight: 2
---

To complete this workshop, you are provided with an AWS account via the AWS Event Engine service. A team hash will be provided to you by event staff.

{{% notice warning %}}
If you are currently logged in to an AWS Account, you can logout using this [link](https://console.aws.amazon.com/console/logout!doLogout)
{{% /notice %}}


### Access Event Engine AWS Account

1. Connect in a new browser tab to the _Event Engine_ portal by browsing to
   [https://dashboard.eventengine.run/](https://dashboard.eventengine.run/).
   Enter the provided hash in the text box. 
   The button on the bottom right corner changes to **Accept Terms & Login**.
   Click on that button to continue.

    ![Event Engine](/images/10_prerequisites/event-engine-initial-screen.png)

    {{% notice tip %}}
Leave the Event Engine tab open (A new tab will be used for the next step).
{{% /notice %}}

2. Choose **AWS Console**, then **Open AWS Console**.

    ![Event Engine Dashboard](/images/10_prerequisites/event-engine-dashboard.png)

3. Access **Cloud9 Instance** from AWS Console.
   
    Enter **Cloud9** on AWS services search and click **Cloud9**

    ![Cloud9 Search](/images/10_prerequisites/console-cloud9.png)

    You could see a **Cloud9 Instance**  provisioned for you already called **SysdigCloud9-workshop**. Click Open to open the cloud9 Session

    ![Workshop Instance](/images/10_prerequisites/cloud9-workshop.png)

## Set permissions for your workspace

{{% notice info %}}
Cloud9 normally manages IAM credentials dynamically. This isn't currently compatible with
the EKS IAM authentication, so we will disable it and rely on the IAM role attached to the Cloud9 instanceinstead.
{{% /notice %}}


1. Click the gear icon (in top right corner),
   and select **AWS SETTINGS**. Turn off **AWS managed temporary credentials** and close the Preferences tab.
   
   ![image](/images/10_prerequisites/iamRoleWorkspace.gif)



## Workshop-specific requirements

Your workstation is ready to start the workshop.Starting from here, when you see command to be entered such as below, you will enter these commands into *Cloud9 IDE* or equivalent terminal of your choice.

1. Close existing terminal and open a new terminal and check your aws identity
   ```bash
   aws sts get-caller-identity
   ```
   The output should look like the example below

   ```
    {
        "UserId": "XXXXXXXXXXXXXXXXXXX:i-nnnnnnnnnnnnnnnnnnnn",
        "Account": "nnnnnnnnnnnn",
        "Arn": "arn:aws:sts::nnnnnnnnnnnn:assumed-role/team-template-SysdigInstanceRole-XXXXXXXXXXX/i-nnnnnnnnnnnn"
    } 
   ```

   A wrong session information would look like 
   ```   
    {   
        "UserId": "XXXXXXXXXXXXXXXXXXX:MasterKey",
        "Account": "nnnnnnnnnnnn",
        "Arn": "arn:aws:sts::nnnnnnnnnnnn:assumed-role/TeamRole/MasterKey"
    }
   ```

2. Clone the workshop repository and get the provided files and execute the script to setup the general requirements for the workshop:

   ```bash
   git clone https://github.com/sysdiglabs/aws-modernization-with-sysdig
   cp -r ./aws-modernization-with-sysdig/static/code/* ./
   rm -rf ./aws-modernization-with-sysdig
   ./connect_eks.sh
   ```


### You are now set up with AWS Cloud9 Instance to continue with rest of the workshop. Skip this section and proceed to **1.Install**


    {{% notice warning %}}
This account will expire at the end of the workshop and the all the resources created will be automatically deprovisioned. You will not be able to access this account after today.
{{% /notice %}}
