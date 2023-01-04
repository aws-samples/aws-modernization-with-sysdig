---
title: "CloudFormation Installer"
chapter: false
weight: 3
---

{{% notice note %}}
Although this installation method is maintained, it is recommended to follow
the terraform installer instructions.
{{% /notice %}}

In this step you'll deploying a Sysdig serverless agent using CloudFormation. 
Follow the instructions below to recreate a complete production environment for Fargate. 

## Prerequisites

During this module, you will deploy and review the required assets to complete this demo:
- *AWS VPC* and *subnetworks*. 
- *Sysdig Secure* account (follow the instructions below to get a new account if needed)



## Prerequisites: Networking

Create a Terraform manifest with the network definition and deploy the stack necessary for this demo to run.

1. Access your [Cloud9](https://us-east-1.console.aws.amazon.com/cloud9/home/product) instance previously created.

2. Download the required assets.

   ```
   mkdir fargate-serverless-agents/terraform-installer
   cd fargate-serverless-agents
   git clone https://github.com/aws-samples/aws-modernization-with-sysdig.git
   cp aws-modernization-with-sysdig/static/code/cloudformation ./cloudformation-installer/
   rm -rf aws-modernization-with-sysdig/
   ```

3. You will find a `network.tf` with the definition of the required network.
   Set the region for your AWS cli and deploy the network with:

    ``` bash
    #instruqt only
    export AWS_REGION=us-east-1
    aws configure set default.region ${AWS_REGION}
    aws configure get default.region

    terraform init && terraform apply \
        -var "prefix=$training" \
        -auto-approve
    ```

    After a couple of minutes, a VPC and two subnets will be created and ready to use.

    ``` bash
    ~/environment/terraform $ terraform apply -var "prefix=$INITIALS" -auto-approve
    aws_vpc.vpc: Creating...
    aws_vpc.vpc: Creation complete after 1s [id=vpc-0a46cc63583ca6c7a]
    aws_subnet.subnet_1: Creating...
    aws_subnet.subnet_2: Creating...
    aws_internet_gateway.igw: Creating...
    aws_internet_gateway.igw: Creation complete after 1s [id=igw-0f351e2c21c9736a7]
    aws_route_table.route_table: Creating...
    aws_route_table.route_table: Creation complete after 0s [id=rtb-0a3e9957ec38d176f]
    aws_subnet.subnet_1: Still creating... [10s elapsed]
    aws_subnet.subnet_2: Still creating... [10s elapsed]
    aws_subnet.subnet_1: Creation complete after 11s [id=subnet-017ea05ec3289ae8f]
    aws_route_table_association.rt_subnet_1: Creating...
    aws_subnet.subnet_2: Creation complete after 11s [id=subnet-0b3f7a629452e07da]
    aws_route_table_association.rt_subnet_2: Creating...
    aws_route_table_association.rt_subnet_1: Creation complete after 1s [id=rtbassoc-00e87d29b3e806907]
    aws_route_table_association.rt_subnet_2: Creation complete after 1s [id=rtbassoc-01e38c9bfd7802db2]

    Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
    ```

4. After applied, assign to the next environment variables the *ids* of the *vpc*, *subnet_1* and *subnet_2*.

    ``` bash
    VPC_ID=$(terraform output -json agentone_vpc | jq -r '.')
    SUBNET_1_ID=$(terraform output -json agentone_subnet_1 | jq -r '.')
    SUBNET_2_ID=$(terraform output -json agentone_subnet_2 | jq -r '.')
    
    ```
