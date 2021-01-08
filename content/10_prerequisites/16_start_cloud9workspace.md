---
title: "3. Launch Cloud9 IDE Workspace"
chapter: false
weight: 16
---

[AWS Cloud9](https://aws.amazon.com/cloud9/) is a cloud-based integrated development environment (IDE) that Let’s you write, run, and debug your code with just a browser. It includes a code editor, debugger, and terminal. Cloud9 comes prepackaged with essential tools for popular programming languages, including JavaScript, Python, PHP, and more, so you don’t need to install files or configure your laptop for this workshop.

We will use Amazon Cloud9 to access our AWS account via the AWS CLI in this Workshop.  There are a few steps to complete to set this up

1. Create a new Cloud9 IDE environment
2. Create an IAM role for your workspace
3. Attach the IAM role to your workspace
4. Configure workshop specific requirements


## Create a new Cloud9 IDE environment

1 . Within the AWS console, use the region drop list to select **us-east-1 (N. Virginia)**.  This will ensure the workshop script provisions the resources in this same region..

2 . Navigate to the [cloud9 console](https://console.aws.amazon.com/cloud9/home) or just search for it under the **AWS console services** menu.

3 . Click the **Create environment** button

4 . For the name use `sysdig-workshop`, then click **Next step**

5 . Select the default instance type **t3.medium**

6 . Leave all the other settings as default and click **Next step** followed by **Create environment**

<!-- ![Deploy Cloud9](/images/10_prerequisites/cloud9.gif) -->
<img src=/images/10_prerequisites/cloud9.gif width="75%" height="57%">

{{% notice info %}}
This will take about 1-2 minutes to provision
{{% /notice %}}

### Configure Cloud9 IDE environment

When the environment comes up, customize the environment by:

1 . Close the **welcome page** tab

2 . Close the **lower work area** tab

3 . Open a new **terminal** tab in the main work area.

4 . Hide the left hand environment explorer by clicking on the left side **environment** tab.

<img src=/images/10_prerequisites/cloud9config.gif width="75%" height="57%">

{{% notice tip %}}
If you don't like this dark theme, you can change it from the **View / Themes** Cloud9 workspace menu.
{{% /notice %}}

{{% notice tip %}}
Cloud9 requires third-party-cookies. You can whitelist the [specific domains]( https://docs.aws.amazon.com/cloud9/latest/user-guide/troubleshooting.html#troubleshooting-env-loading).  You are having issues with this, Ad blockers, javascript disablers, and tracking blockers should be disabled for the cloud9 domain, or connecting to the workspace might be impacted.
{{% /notice %}}


## Create an IAM role for your workspace

{{% notice info %}}
Starting from here, when you see command to be entered such as below, you will enter these commands into Cloud9 IDE. You can use the **Copy to clipboard** feature (right hand upper corner) to simply copy and paste into Cloud9. In order to paste, you can use Ctrl + V for Windows or Command + V for Mac.
{{% /notice %}}

1. Follow [this deep link to create an IAM role with Administrator access.](https://console.aws.amazon.com/iam/home#/roles$new?step=review&commonUseCase=EC2%2BEC2&selectedUseCase=EC2&policies=arn:aws:iam::aws:policy%2FAdministratorAccess)
2. Confirm that **AWS service** and **EC2** are selected, then click **Next: Permissions** to view permissions.
3. Confirm that **AdministratorAccess** is checked, then click **Next: Tags**, then **Next: Review** to review.
4. Enter `Sysdig-Workshop-Admin` for the Role name, and select **Create role**
<img src=/images/10_prerequisites/iamRole.gif width="75%" height="57%">


## Attach the IAM role to your Workspace

1. Follow [this deep link to find your Cloud9 EC2 instance](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:search=aws-cloud9-sysdig;sort=desc:launchTime)

2. Select the instance, then choose **Actions / Security / Modify IAM role**

3. Choose **Sysdig-Workshop-Admin** from the **IAM Role** drop down, and select **Save**

<img src=/images/10_prerequisites/attachIAMRole.gif width="75%" height="57%">



## Configure workspace for Sysdig Workshop

{{% notice info %}}
Cloud9 normally manages IAM credentials dynamically. This isn't currently compatible with
the EKS IAM authentication, so we will disable it and rely on the IAM role instead.
{{% /notice %}}

  1. Return to your workspace and click the gear icon (in top right corner), or click to open a new tab and choose "Open Preferences"

  2. Select **AWS SETTINGS** and turn off **AWS managed temporary credentials**

  3. Close the Preferences tab

     <img src=/images/10_prerequisites/iamRoleWorkspace.gif width="100%" >

  4. Copy and run (paste with **Ctrl+P**) the commands below.

     Before running it, review what it does by reading through the comments.


```sh
# Update awscli
sudo pip install --upgrade awscli && hash -r

# Install jq command-line tool for parsing JSON, and bash-completion
sudo yum -y install jq gettext bash-completion moreutils

# Install yq for yaml processing
echo 'yq() {
docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc

# Verify the binaries are in the path and executable
for command in jq aws
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
echo "export AWS_REGION=${AWS_REGION}" |
tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region

# Validate that our IAM role is valid.
aws sts get-caller-identity --query Arn | grep Sysdig-Workshop-Admin -q && echo "IAM role valid" || echo "IAM role NOT valid"
```

{{% notice warning %}}
If the IAM role is not valid, <span style="color: red;">**DO NOT PROCEED**</span>. Go back and confirm the steps on this page.
{{% /notice %}}
