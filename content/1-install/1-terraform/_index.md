---
title: "Cloud: Terraform-based"
chapter: true
weight: 1
---

{{% notice info %}}
*Estimated sub-module duration: 3-5 minutes.*
{{% /notice %}}


{{% notice note %}}
This steps will explain how to deploy the Sysdig Secure Cloud stack
for AWS with Terraform for a **single account**. 
It is not within the scope of this workshop to explain how to deploy it in an **organization account**.
To learn more about this, review the docs [here](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-aws/#for-organizationalmanagement-account).
{{% /notice %}}


## Requirements

To install the Sysdig Secure for AWS integration, it is required:
- Terraform installed in your host (v.3.1+).
- Sysdig Secure SaaS account with administrator permissions.


## Install

1. Log into Sysdig Secure, and browse to **Integrations > Data Sources > Cloud Accounts**, 
then click on [**Connect Cloud Account > AWS > Terraform Single Account**](https://secure.sysdig.com/#/data-sources/cloud-accounts?setupModalEnv=AWS&installContentDisplayType=tabular&accountType=single).

    ![Install with Terraform](/images/1-installation/aws.png)

2. In the menu, insert a valid aws region (for this workshop, use `us-east-1`)
   and copy the resulting content.

3. Go to the terminal window and
   create a folder with the `main.tf` file inside.
   Copy the terraform manifest from the previous step in this file.

   ```
    cd ~
    mkdir tf-sysdig-secure-cloud && cd $_
    touch main.tf
   ```

4. Some components (*Vulnerability Management*) are disabled by default.
   To include them, add the next input variables inside of the `"secure-for-cloud_example_single-account"` module definition.
   Be careful with indenting:

    ```terraform
        deploy_beta_image_scanning_ecr = true
    ```

    The final result should look like this:

    {{% code-to-md "/static/code/cloudvision/aws-single-tf.tf" "terraform" %}}

5. Now, just initialize and execute Terraform with:

    ```bash
    terraform init && \
    terraform apply --auto-approve
    ```

6. Wait until the installation finishes.
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

To learn how to check that the installation was successful, visit the [next section](/1-install/3-cloudreviewaccounts.html).


## Digging deeper

Although it is not part of this workshop, it is recommended to store
the state of the Terraform deployment on a backed-up backend.

By default, Terraform stores its state on `local`.
Run the next command to view the state file:

```
cat terraform.tfstate
```

This file describes the infrastructure that
were created after the `terraform apply` command is executed.
The next time you run Terraform, it will compare
the state file (real state) with the definition of the infrastructure (expected state)
and will make all the necessary changes for this two files to match.

This file is important, as it describes what's the real status of your infrastructure.
If this file is lost, Terraform will think the resources were never created.
This will create some trouble.
Toi avoid this, Terraform recommends keeping the state remotely.

There are multiples alternatives, like storing the state in [S3](https://www.terraform.io/language/settings/backends/s3).

1. Create an S3 backed and name it `ssfc-terraform-state` and a key to access its contents.
2. Add the next module information to the `main.tf` you created above:

    ```terraform
    terraform {
        backend "s3" {
            bucket = "ssfc-terraform-state"
            key    = "path/to/my/key"
            region = "us-east-1"
        }
    }
    ```

3. Reapply the terraform manifest.

    ```bash
    terraform apply --auto-approve
    ```