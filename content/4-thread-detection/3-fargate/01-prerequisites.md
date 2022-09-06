+++
title = "Prerequisites"
chapter = true
weight = 10
+++


In this step you will deploy and review the required assets to complete this demo:
- *AWS VPC* and *subnetworks*
- *Sysdig Secure* account (follow the instructions here to get a new account if )

## Networking: VPC and subnets

Terraform has already been installed in this host. 
Create a Terraform manifest with the network definition and deploy the stack necessary for this demo to run.

1. Access your [Cloud9](https://console.aws.amazon.com/cloud9/home/product) instance previously created.

2. Create a file `network.tf` with the definition below (just copy and execute in your terminal):

```
mkdir terraform
cd terraform

cat << 'EOF' > ./network.tf
variable "prefix" {
  type = string
}
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "${var.prefix}-fargate-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-fargate-igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-fargate-route-table"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/25"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-fargate-subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.128/25"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-fargate-subnet-2"
  }
}

resource "aws_route_table_association" "rt_subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "rt_subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

output "agentone_vpc" {
  value = aws_vpc.vpc.id
}

output "agentone_subnet_1" {
  value = aws_subnet.subnet_1.id
}

output "agentone_subnet_2" {
  value = aws_subnet.subnet_2.id
}
 
EOF
```

3. Before creating your networking infrastructure for Fargate, define a value for `INITIALS` if you did not in the previous module. Use a string you can easily identify and apply it with:

    **Please be sure that you just include *alphanumeric* characters**.

```
INITIALS=<your_initials_here>
 
```

4. And apply it with:

```
terraform init
terraform apply -var "prefix=$INITIALS" -auto-approve
```

After a couple of minutes, a VPC and two subnets will be created and ready to use.

```
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

5. After applied, assign to the next environment variables the *ids* of the *vpc*, *subnet_1* and *subnet_2*.

```
VPC_ID=$(terraform output -json agentone_vpc | jq -r '.')
SUBNET_1_ID=$(terraform output -json agentone_subnet_1 | jq -r '.')
SUBNET_2_ID=$(terraform output -json agentone_subnet_2 | jq -r '.')
 
```

## Sysdig Secure account

Sysdig Secure provides security for containers, Kubernetes, and cloud services. A trial account is more than enough to test all you can do with Sysdig Secure and AWS Fargate. Follow the next steps if you did not completed the free trial registration for Sysdig Secure in [Prerequisites]({{< ref "0-prerequisites/2-sysdig_account/_index.md" >}}).

1. **Register** for a [trial account](https://sysdig.com/company/free-trial-secure/). No credit card or payments are required.

2. Complete the required fields and click **Submit**.

3. Open your mail inbox and login using the provided link.

4. Done!

---

You have everything you need to deploy a *Sysdig Serverless Agent* and instrument this task running in *Fargate*.