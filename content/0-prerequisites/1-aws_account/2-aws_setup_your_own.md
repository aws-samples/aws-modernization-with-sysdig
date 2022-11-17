---
title: "Running the workshop on your own"
chapter: false
weight: 3
---

{{% notice note %}}
Only complete this section if you are running the workshop on your own.
If you are at an AWS hosted event (such as re:Invent, Kubecon, Immersion Day, etc),
go to [Start the workshop at an AWS event](/0-prerequisites/1-aws_account/1-aws_event_setup.html).
If you already completed the AWS event Setup, jump to the next step
to [configure your Cloud 9 instance](/0-prerequisites/3-cloud9.html).
{{% /notice %}}


## Requirements

Your account must have the ability to create new IAM roles and scope other IAM permissions.


## Configure your account

1. If you don't already have an AWS account with Administrator access: 
   [create one now by clicking here](https://aws.amazon.com/getting-started/).

2. Once you have an AWS account, ensure you are following the remaining workshop steps
as an IAM user with administrator access to the AWS account:
[Create a new IAM user to use for the workshop](https://console.aws.amazon.com/iam/home?#/users$new). To do so, follow the next steps:

   1. Enter the user details:
        ![Sysdig Trial](/images/10_prerequisites/iam-1-create-user.png)

   2. Attach the AdministratorAccess IAM Policy:
       ![Sysdig Trial](/images/10_prerequisites/iam-2-attach-policy.png)

   3. Click to create the new user:
       ![Sysdig Trial](/images/10_prerequisites/iam-3-create-user.png)

   4. Take note of the login URL and save:
       ![Sysdig Trial](/images/10_prerequisites/iam-4-save-url.png)

   5. Access the console with the new admin user.


{{% notice warning %}}
You are responsible for the cost of the AWS services used while running this workshop in your AWS account.
{{% /notice %}}
