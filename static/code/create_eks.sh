#!/bin/bash

# install kubectl for 1.22 https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.15/2022-10-31/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# download and deploy EKS cluster from Hashicorp demo https://github.com/hashicorp/learn-terraform-provision-eks-cluster
git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster
cd learn-terraform-provision-eks-cluster
# change machine types for first instance type
sed -ie 's/t3.small/t3.large/g' eks-cluster.tf
sed -ie 's/us-east-2/us-east-1/g' variables.tf
# deploy cluster
terraform init && terraform apply -auto-approve

# configure kubectl
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)