#!/bin/bash

# install kubectl for 1.22 https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.15/2022-10-31/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# download and deploy EKS cluster from Hashicorp demo https://github.com/hashicorp/learn-terraform-provision-eks-cluster
# git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster
# we are providing the source files with https://github.com/sysdiglabs/aws-modernization-with-sysdig/pull/19
cd learn-terraform-provision-eks-cluster

# patch
# change machine types for first instance type as well as the region
#sed -ie 's/t3.small/c5.xlarge/g' main.tf
sed -ie 's/us-east-2/us-east-1/g' variables.tf
# comment out terraform-cloud to set local terraform
sed -ie '6,10 s/^/#/' terraform.tf

# deploy cluster
terraform init && terraform apply -auto-approve

# configure kubectl
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)

# Kubectl shell completion
cat << EOF > /root/.kube/completion.bash.inc
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
EOF


echo 'source /root/.kube/completion.bash.inc' >> /root/.bashrc

# falco event generator 
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
kubectl create ns event-generator
helm upgrade --install event-generator falcosecurity/event-generator \
  --namespace event-generator \
  --create-namespace \
  --set config.loop=true \
  --set config.actions=""
