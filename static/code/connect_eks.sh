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
#export REGION=us-east-1
export AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)

repositories=( "$ECR_NAME" "mysql" "postgres" "redis" )

for repo in ${repositories[@]}; do
    aws ecr describe-repositories --repository-name ${repo} --region $AWS_REGION
done

# auth AWS CLI with registry
aws ecr get-login-password --region $AWS_REGION | \
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

# install kubectl for 1.22 https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.15/2022-10-31/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# download and deploy EKS cluster from Hashicorp demo https://github.com/hashicorp/learn-terraform-provision-eks-cluster
# git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster
# we are providing the source files with https://github.com/sysdiglabs/aws-modernization-with-sysdig/pull/19
#cd learn-terraform-provision-eks-cluster

# patch
# change machine types for first instance type as well as the region
#sed -ie 's/t3.small/t3.large/g' main.tf
#sed -ie 's/us-east-2/us-east-1/g' variables.tf
# comment out terraform-cloud to set local terraform
#sed -ie '6,10 s/^/#/' terraform.tf

# deploy cluster
#terraform init && terraform apply -auto-approve

# export EKS cluster name
export EKS_CLUSTER=$(aws eks list-clusters | jq -r '.clusters[]')

# configure kubectl
aws eks --region $AWS_REGION update-kubeconfig \
    --name $EKS_CLUSTER

# Kubectl shell completion
# cat << EOF > /root/.kube/completion.bash.inc
# source /usr/share/bash-completion/bash_completion
# source <(kubectl completion bash)
# alias k=kubectl
# complete -o default -F __start_kubectl k
# EOF


# echo 'source /root/.kube/completion.bash.inc' >> /root/.bashrc

# falco event generator 
echo "Adding Helm Repo and update"
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
echo "Creating EKS Name Server"
kubectl create ns event-generator
helm upgrade --install event-generator falcosecurity/event-generator \
  --namespace event-generator \
  --create-namespace \
  --set config.loop=true \
  --set config.actions=""
