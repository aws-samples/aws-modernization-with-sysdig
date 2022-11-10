+++
title = "Cloud: Terraform-based"
chapter = true
weight = 1
+++

{{% notice note %}}
This steps will explain how to deploy the Sysdig Secure Cloud stack for AWS
with Terraform for a **single account**. It is not within the scope of this workshop to explain how to deploy it in an **organization account**. To learn more about this, review the docs [here](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-aws/#for-organizationalmanagement-account).
{{% /notice %}}

## Requirements

<!-- Can we automate a script that checks for the user if all those permissions are meet? Here we don't need them because the environment is properly configured, but it might be useful for the general user experience. -->
To install the Sysdig Secure for AWS integration, it is required:
- Terraform installed in your host (v.3.1+). For previous versions of terraform, use `version 0.9.10 of the secure-for-cloud module`. Terraform is installed available in the host provided for this workshop during Prerequisites.
- Sysdig Secure SaaS account with administrator permissions.


## Connect your Cloud Account

The next steps will deploy Sysdig Secure for cloud using Terraform. To connect your cloud account to Sysdig and deploy the SSC stack:

1. Log into Sysdig Secure, and browse to **Get Started**, then **Connect your Cloud Account**, then click **Launch Stack**

2. Create a `SSfC.tf` file with the output from the previous step.
    Modify on the editor the `aws.region` field with your preferred region. 
    For this training, you can use `us-east-1`.

3. Deploying the Vulnerability Management (Image Scanning) *submodules*.

    This submodules are disabled in the default installed. To include them, 
    include the next input variables in the Terraform definition:

    ```terraform
    deploy_image_scanning_ecs = true
    deploy_image_scanning_ecr = true
    ```

    The final result should be like this:

    ```terraform
    terraform {
    required_providers {
        sysdig = {
            source  = "sysdiglabs/sysdig"
        }
    }
    }

    provider "sysdig" {
    sysdig_secure_url       = "<your_sysdig_secure_region_endpoint"
    sysdig_secure_api_token = "f4k3k375-f4k3-f4k3-f4k3-f4k3k375f4k3"
    }

    provider "aws" {
    region = "us-east-1"
    }

    module "secure-for-cloud_example_single-account" {
    source = "sysdiglabs/secure-for-cloud/aws//examples/single-account"
    deploy_image_scanning_ecs = true
    deploy_image_scanning_ecr = true
    }
    ```

4. Launch Terraform with:

    ```bash
    terraform init \
    && terraform apply --auto-approve
    ```


5. Wait until the installation finishes.
    You'll see the Terraform logs displaying the progress of the install
    (it should not take more than 2 minutes to deploy):

    ```logs
    Initializing modules...
    Downloading registry.terraform.io/sysdiglabs/secure-for-cloud/aws 0.10.1 for secure-for-cloud_example_single-account...
    - secure-for-cloud_example_single-account in .terraform/modules/secure-for-cloud_example_single-account/examples/single-account
    - secure-for-cloud_example_single-account.cloud_bench in .terraform/modules/secure-for-cloud_example_single-account/modules/services/cloud-bench
    - secure-for-cloud_example_single-account.cloud_connector in .terraform/modules/secure-for-cloud_example_single-account/modules/services/cloud-connector-ecs
    - secure-for-cloud_example_single-account.cloud_connector.cloud_connector_sqs in .terraform/modules/secure-for-cloud_example_single-account/modules/infrastructure/sqs-sns-subscription
    - secure-for-cloud_example_single-account.cloudtrail in .terraform/modules/secure-for-cloud_example_single-account/modules/infrastructure/cloudtrail
    - secure-for-cloud_example_single-account.codebuild in .terraform/modules/secure-for-cloud_example_single-account/modules/infrastructure/codebuild
    - secure-for-cloud_example_single-account.ecs_vpc in .terraform/modules/secure-for-cloud_example_single-account/modules/infrastructure/ecs-vpc
    Downloading registry.terraform.io/terraform-aws-modules/vpc/aws 3.16.1 for secure-for-cloud_example_single-account.ecs_vpc.vpc...
    - secure-for-cloud_example_single-account.ecs_vpc.vpc in .terraform/modules/secure-for-cloud_example_single-account.ecs_vpc.vpc
    - secure-for-cloud_example_single-account.resource_group in .terraform/modules/secure-for-cloud_example_single-account/modules/infrastructure/resource-group
    - secure-for-cloud_example_single-account.ssm in .terraform/modules/secure-for-cloud_example_single-account/modules/infrastructure/ssm

    Initializing the backend...

    Initializing provider plugins...
    - Finding hashicorp/aws versions matching ">= 3.50.0, >= 3.62.0, >= 3.73.0, >= 4.0.0"...
    - Finding hashicorp/random versions matching ">= 3.1.0"...
    - Finding sysdiglabs/sysdig versions matching ">= 0.5.29, >= 0.5.33"...
    - Installing sysdiglabs/sysdig v0.5.40...
    - Installed sysdiglabs/sysdig v0.5.40 (signed by a HashiCorp partner, key ID 0A2458C5D4F39147)
    - Installing hashicorp/aws v4.35.0...
    - Installed hashicorp/aws v4.35.0 (signed by HashiCorp)
    - Installing hashicorp/random v3.4.3...
    - Installed hashicorp/random v3.4.3 (signed by HashiCorp)

    Partner and community providers are signed by their developers.
    If you'd like to know more about provider signing, you can read about it here:
    https://www.terraform.io/docs/cli/plugins/signing.html

    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.

    Terraform has been successfully initialized!

    (...)
    (modules being created...)

    Apply complete! Resources: 53 added, 0 changed, 0 destroyed.
    ```


## How to check that the Services are Working fine?

There are [different methods](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-aws/#confirm-the-services-are-working) to check that the installation was successful. 

Visit the Data Sources (Cloud Accounts) section](https://secure.sysdig.com/#/data-sources/cloud-accounts) to review that an account with your Account ID is connected.

![Cloud Account Connected](/images/1-installation/cloud_account_connected.png)


## Digging deeper

Although it is not part of this workshop, it is recommended to store
the state of the Terraform deployment on a backed-up backend.

By default (method used on the steps above), Terraform stores its state on `local`.

There are multiples alternatives to this, like [S3](https://www.terraform.io/language/settings/backends/s3).

```
terraform {
  backend "s3" {
    bucket = "ssfc-terraform-state"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```