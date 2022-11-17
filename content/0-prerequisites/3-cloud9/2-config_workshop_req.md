---
title: "Configure workshop specific requirements"
chapter: false
weight: 2
---

{{% notice info %}}
Starting from here, when you see command to be entered such as below, you will enter these commands into Cloud9 IDE. You can use the **Copy to clipboard** feature (right hand upper corner) to simply copy and paste into Cloud9. In order to paste, you can use Ctrl + V for Windows or Command + V for Mac.
{{% /notice %}}

## Configure workspace for Sysdig Workshop

{{% notice info %}}
Cloud9 normally manages IAM credentials dynamically. This isn't currently compatible with
the EKS IAM authentication, so we will disable it and rely on the IAM role instead.
{{% /notice %}}

1. Return to your workspace and click the gear icon (in top right corner),
   or click to open a new tab and choose "Open Preferences"

2. Select **AWS SETTINGS** and turn off **AWS managed temporary credentials**

3. Close the Preferences tab

   <img src=/images/10_prerequisites/iamRoleWorkspace.gif width="100%" >

4. Copy and run (paste with **Ctrl+P**) the commands below.

   Before running it, review what it does by reading through the comments.

   The deployment of the EKS cluster will take some time to complete,
   you can jump to the next 


   ```sh
   # Uninstall awscli v1 and install awscli v2
   sudo pip uninstall awscli -y
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   hash  -r

   # Install jq command-line tool for parsing JSON, and bash-completion
   sudo yum -y install jq gettext bash-completion moreutils

   # install helm
   curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
   chmod 700 get_helm.sh
   ./get_helm.sh

   # Install yq for yaml processing
   echo 'yq() {
   docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
   }' | tee -a ~/.bashrc && source ~/.bashrc

   # Verify the binaries are in the path and executable
   for command in jq aws yq helm terraform
   do
   which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND"
   done

   # Remove existing credentials file.
   rm -vf ${HOME}/.aws/credentials

   # Set the ACCOUNT_ID and the region to work with our desired region
   export AWS_REGION=$(aws configure get region)
   #export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
   test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set

   # Configure .bash_profile
   export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
   echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
   echo "export AWS_REGION=${AWS_REGION}" |
   tee -a ~/.bash_profile
   aws configure set default.region ${AWS_REGION}
   aws configure set AWSACCOUNT.region ${AWS_REGION}
   aws configure get default.region

   # Validate that our IAM role is valid.
   aws sts get-caller-identity --query Arn | grep Sysdig-Workshop-Admin -q && echo "IAM role valid" || echo "IAM role NOT valid"
   ```


   {{% notice warning %}}
If the IAM role is not valid, <span style="color: red;">**DO NOT PROCEED**</span>. Go back and confirm the steps on this page.
{{% /notice %}}

5. If you are going to run the Runtime Security and Actionable Compliance modules for EKS, 
   launch a new EKS cluster with the next command.
   (The EKS cluster deployment in AWS will take about 10 minutes to complete).

   ```
   # download and deploy EKS cluster from Hashicorp demo
   git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster
   cd learn-terraform-provision-eks-cluster
   # change machine types for first instance type
   sed -e 's/t3.small/t3.large/g' eks-cluster.tf
   # deploy cluster
   terraform init && terraform apply -auto-approve

   # configure kubectl
   aws eks --region $(terraform output -raw region) update-kubeconfig \
      --name $(terraform output -raw cluster_name)
   ```

