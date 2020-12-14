---
title: "1. Access AWS Account..."
chapter: true
weight: 11
---

# Access an AWS account
To start the workshop, follow one of the following depending on whether you are...

* Attending an AWS hosted event, or
* Running the workshop on your own

<!--
* [Attending an AWS hosted event](13_aws_event.html), or
* [Running the workshop on your own](14_self_paced.html)
 -->

Both options are explained below.

Once you have completed with either setup, continue with [**Launch a Cloud9 IDE Workspace**](/10_prerequisites/16_start_cloud9workspace.html)


## Attending an AWS hosted event

To complete this workshop, you are provided with an AWS account via the AWS Event Engine service. A team hash will be provided to you by event staff.

{{% notice warning %}}
If you are currently logged in to an AWS Account, you can logout using this [link](https://console.aws.amazon.com/console/logout!doLogout)
{{% /notice %}}


### Create AWS Account

1 . Connect to the portal by clicking the button or browsing to [https://dashboard.eventengine.run/](https://dashboard.eventengine.run/). The following screen shows up. Enter the provided hash in the text box. The button on the bottom right corner changes to **Accept Terms & Login**. Click on that button to continue.

![Event Engine](/images/10_prerequisites/event-engine-initial-screen.png)

{{% notice tip %}}
Leave the Event Engine tab open (A new tab will be used for the next step)
{{% /notice %}}

2 . Choose **AWS Console**, then **Open AWS Console**.


![Event Engine Dashboard](/images/10_prerequisites/event-engine-dashboard.png)

3 . Use a single region for the duration of this workshop. This workshop supports the following regions:

* us-east-1 (US East - N.Virginia)

Please select **US East (N.Virginia)** in the top right corner.

![Event Engine Region](/images/10_prerequisites/event-engine-region.png)

{{% notice warning %}}
This account will expire at the end of the workshop and the all the resources created will be automatically deprovision-ed. You will not be able to access this account after today.
{{% /notice %}}


## Running the workshop on your own

{{% notice warning %}}
Only complete this section if you are running the workshop on your own. If you are at an AWS hosted event (such as re:Invent, Kubecon, Immersion Day, etc), go to [Start the workshop at an AWS event](../aws_event/).
{{% /notice %}}

{{% children %}}

{{% notice warning %}}
Your account must have the ability to create new IAM roles and scope other IAM permissions.
{{% /notice %}}

{{% notice warning %}}
You are responsible for the cost of the AWS services used while running this workshop in your AWS account.
{{% /notice %}}

1. If you don't already have an AWS account with Administrator access: [create
one now by clicking here](https://aws.amazon.com/getting-started/)

1. Once you have an AWS account, ensure you are following the remaining workshop steps
as an IAM user with administrator access to the AWS account:
[Create a new IAM user to use for the workshop](https://console.aws.amazon.com/iam/home?#/users$new)

1. Enter the user details:
![Sysdig Trial](/images/10_prerequisites/iam-1-create-user.png)

1. Attach the AdministratorAccess IAM Policy:
![Sysdig Trial](/images/10_prerequisites/iam-2-attach-policy.png)

1. Click to create the new user:
![Sysdig Trial](/images/10_prerequisites/iam-3-create-user.png)

1. Take note of the login URL and save:
![Sysdig Trial](/images/10_prerequisites/iam-4-save-url.png)
