
+++
title = "Terraform-based"
chapter = true
weight = 1
+++

{{% notice note %}}
This steps will explain how to deploy the Sysdig Secure Cloud stack for AWS
with Terraform for a **single account**. It is not within the scope of this workshop to explain how to deploy it in an **organization account**. To learn more about this, review the docs [here](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-aws/#for-organizationalmanagement-account).
{{% /notice %}}

## Requirements

Can we automate a script that checks for the user if all those permissions are meet? Here we don't need them because the environment is properly configured, but it might be useful for the general user experience.

## Connect your Cloud Account

The next steps will deploy Sysdig Secure for cloud using Terraform. To connect your cloud account to Sysdig and deploy the CF Template:

1. Log into Sysdig Secure, and browse to **Getting Started**, then **Connect your Cloud Account**, then click **Launch Stack**

2. Create a `.tf` file with the output from the previous step.
3. Deploying the Vulnerability Management (Image Scanning) *submodules*.

    This submodules are disabled in the default installed. To include them, 
    include the next input variables in the Terraform definition:

    ```
    deploy_image_scanning_ecs = true
    deploy_image_scanning_ecr = true
    ```

4. Launch Terraform with:

    ```
    terraform init && terraform apply --auto-approve
    ```


5. Wait until the installation finishes

<!-- Insert gif image here -->

## How to check that the Services are Working fine?

Visit... https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-aws/#confirm-the-services-are-working