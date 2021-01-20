---
title: "4.2 Create IAM role"
chapter: false
weight: 13
---

## Create an IAM role for your workspace

{{% notice info %}}
Starting from here, when you see command to be entered such as below, you will enter these commands into Cloud9 IDE. You can use the **Copy to clipboard** feature (right hand upper corner) to simply copy and paste into Cloud9. In order to paste, you can use Ctrl + V for Windows or Command + V for Mac.
{{% /notice %}}

1. Follow [this deep link to create an IAM role with Administrator access.](https://console.aws.amazon.com/iam/home#/roles$new?step=review&commonUseCase=EC2%2BEC2&selectedUseCase=EC2&policies=arn:aws:iam::aws:policy%2FAdministratorAccess)
2. Confirm that **AWS service** and **EC2** are selected, then click **Next: Permissions** to view permissions.
3. Confirm that **AdministratorAccess** is checked, then click **Next: Tags**, then **Next: Review** to review.
4. Enter `Sysdig-Workshop-Admin` for the Role name, and select **Create role**
   <img src=/images/10_prerequisites/iamRole.gif width="75%" height="57%">