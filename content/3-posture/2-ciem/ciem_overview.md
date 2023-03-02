---
title: "Exploring and remediating IAM Policies"
chapter: true
weight: 2
---

Access your to Sysdig Secure and select
[**Posture > Identity & Access > Overview**](https://secure.sysdig.com/#/cloudSec/analysis).

Select from the top dropdown menu your cloud account (_per ID_) to filter and observe the different panels,
organized based on different categories:

1. **Users**: Sysdig provides information based on user activity to compare granted
      permissions with used permissions and remediate them.
2. **Roles**: for every role available, you 
      can learn which policies are attached to it, and its details.
3. **IAM Policies**: Alternatively, you can select the view all the existing policies and,
      from there, click on **Optimize Policy** to modify the policy. The suggestion
      will be based on all users and roles activities.

![Overview](/images/50_module_3/ciem_overview.png)


## Remediation workflow

Often one of the first things companies want to do when tackling Identity and Access Management
is looking for inactive users with admin rights and no MFA enabled.
Multiple filters are applicable.

1. In the initial page, select one of the users.

    ![User](/images/50_module_3/ciem_user.png)

2. From here, you can observe which IAM Policies has been attached to the user.
    Also, other information to understand the risk level, like last access date,
    administrator level or status of access key or authentication methods.

3. Click on `Optimize IAM Policy`.
    A new policy will be generated, based on available user activity on AWS logs.
    Observe how this user initially had more than ten thousand permissions,
    when he only needed `ec2:describevpcs` action access in this account.

    ![Recommended Policy](/images/50_module_3/ciem_policy_recommended.png)

4. The remediation workflow allows you to jump directly into the AWS console
    to create a new policy for the user. After attached to the user (and the existing policies removed)
    the principle of Least Privilege Policy will be applied.


### Alternative workflows

Every page within the Identity and Access section can be downloaded as a CSV file. 
This means that you can easily export this information to share with other teams and take action.

Sysdig also provides an overview of existing custom Policies and permissions attached to them. 
Explore some of the remediation workflows for the roles in your account.

AWS Managed Policies cannot be modified. Alternatively, use the suggestions 
to tailor a custom policy and then:
- unattach the managed policy from all users affected
- create new policies with the least permissive suggestion
- attache the new policy to the existing users


### Workshop IAM demo activity

For training porpuses, find below an orientative script to 
generate some IAM activity in your account:

```bash
#!/bin/bash

# based on: https://aws.amazon.com/premiumsupport/knowledge-center/iam-assume-role-cli/

# users
touch users.txt
for i in {0..9}
do

    aws iam create-user --user-name user$i
    echo "user$i" > users.txt
done

# policies
cat <<EOF > permissive-sample-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "iam:ListRoles",
        "sts:AssumeRole"
      ],
      "Resource": "*"
    }
  ]
}
EOF

cat <<EOF > another-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "iam:ListRoles",
        "sts:AssumeRole"
      ],
      "Resource": "*"
    }
  ]
}
EOF

aws iam create-policy --policy-name another-policy --policy-document another-policy.json > sample-policy.txt
aws iam create-policy --policy-name permissive-sample-policy --policy-document permissive-sample-policy.json > permissive-policie.txt


# bind user with policies
while read user;
do
    if (( RANDOM % 2 )); 
    then 
        aws iam attach-user-policy --user-name $user \
            --policy-arn $(permissive-policie.txt)
    else 
        aws iam attach-user-policy --user-name $user \
            --policy-arn $(sample-policy.txt)
    fi
done < users.txt

# review attached policies
while read user;
do
    aws iam list-attached-user-policies --user-name $user
done < users.txt

# a trust policy
cat <<EOF > trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "AWS": "$AWS_ACCOUNT"
    },
    "Action": "sts:AssumeRole"
  }
}
EOF

aws iam create-role --role-name example-role --assume-role-policy-document trust-policy.json
aws iam attach-role-policy --role-name example-role --policy-arn "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
aws iam list-attached-role-policies --role-name example-role

```