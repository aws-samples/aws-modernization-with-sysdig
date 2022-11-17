---
title: "Machine IAM role"
chapter: false
weight: 1
---

## Create the IAM role for your workspace

1. Follow [this deep link to create an IAM role with Administrator access.](https://console.aws.amazon.com/iam/home#/roles$new?step=review&commonUseCase=EC2%2BEC2&selectedUseCase=EC2&policies=arn:aws:iam::aws:policy%2FAdministratorAccess)
   
2. Confirm that **AWS service** and **EC2** are selected,
   then click **Next: Permissions** to view permissions.

3. Confirm that **AdministratorAccess** is checked,
   then click **Next: Tags**, then **Next: Review** to review.

4. Enter `Sysdig-Workshop-Admin` for the Role name,
   and select **Create role**

    ![Create IAM Role](/images/10_prerequisites/iamRole.gif)


## Attach the IAM role to your Workspace

1. Follow [this deep link to find your Cloud9 EC2 instance](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:search=aws-cloud9-sysdig;sort=desc:launchTime)

2. Select the instance, then choose **Actions / Security / Modify IAM role**

3. Choose **Sysdig-Workshop-Admin** from the **IAM Role** drop down, and select **Save**

    ![Attach IAM Role](/images/10_prerequisites/attachIAMRole.gif)
