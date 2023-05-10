#!/bin/bash

# Uninstall awscli v1 and install awscli v2
rm README.md
sudo pip uninstall awscli -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
hash  -r
rm awscliv2.zip
rm -r aws

# Install jq command-line tool for parsing JSON, and bash-completion
sudo yum -y install jq gettext bash-completion moreutils

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh && ./get_helm.sh
rm ./get_helm.sh
# Verify the binaries are in the path and executable
for command in jq aws helm terraform
do
    which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND"
done

# Remove existing credentials file.
rm -vf ${HOME}/.aws/credentials

# Set the ACCOUNT_ID and the region to work with our desired region
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set

# Configure .bash_profile
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}



# ECR Registry for module 2, create repository
export ECR_NAME=aws-workshop
export REGION=us-east-1

aws ecr create-repository --repository-name $ECR_NAME \
    --image-scanning-configuration scanOnPush=false \
    --region $REGION

aws ecr create-repository --repository-name mysql \
    --image-scanning-configuration scanOnPush=false \
    --region $REGION

aws ecr create-repository --repository-name postgres \
    --image-scanning-configuration scanOnPush=false \
    --region $REGION

aws ecr create-repository --repository-name redis \
    --image-scanning-configuration scanOnPush=false \
    --region $REGION

# auth AWS CLI with registry
export AWS_ACCOUNT=$(aws sts get-caller-identity | jq '.Account' | xargs)
echo "$ECR_NAME, $REGION, $AWS_ACCOUNT"
aws ecr get-login-password --region $REGION | \
    docker login --username AWS --password-stdin \
    $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com

# populate ECR
repositories=( \
    "mysql:5.7" \
    "postgres:13" \
    "redis:6" \
)

for repo_src in ${repositories[@]}; do

    docker pull ${repo_src}

    repo_dest=${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/${repo_src}
    docker tag ${repo_src} ${repo_dest}
    docker push ${repo_dest}
done

   
# Validate that our IAM role is valid.
aws sts get-caller-identity --query Arn | grep Sysdig-Workshop-Admin -q && echo "IAM role valid" || echo "IAM role NOT valid"
