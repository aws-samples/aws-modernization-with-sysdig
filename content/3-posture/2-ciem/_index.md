---
title: "2. CIEM"
chapter: true
weight: 2
---

Cloud vendors like AWS stablish a
[Shared Responsibility Model](https://aws.amazon.com/compliance/shared-responsibility-model/)
in which the cloud vendor is responsible for the security "_of_" the cloud,
whereas the customer (_you) is responsible for the security "_in_" the cloud.
One of the key elements that cloud users have to protect too are
the **Identity and Access** configurations.

Before cloud, controlling **who** accessed **what** was a doable task.
But cloud adds complexity and hundreds of different resources.
Misconfiguration of any of the policies defining permissions (for users or automated agents)
is one of the main entry points for attackers.

In this section, you will learn how Sysdig presents you a prioritized view of:
- excessive or unnecessary permissions
- inactive users
- suspicious activity based on assigned permissions
- recent changes in permissions

And, most importantly, it provides a **remediation** workflow to suggest
and apply fixes to improve your Identity and Access Cloud posture.


# Cloud Identity and Entitlements Management (CIEM)

{{% notice info %}}
This section provides an overview of Sysdig CIEM.
To provide accurate suggestions, Sysdig stablish a minimal baseline of time (learning mode)
that might be bigger than the lifespan of this workshop. Hence, you might
not be able to test it live with the same examples.
{{% /notice %}}

Access your to Sysdig Secure and select
[**Posture > Identity and Access > Overview**](https://secure.sysdig.com/#/cloudSec/analysis).

Here you will be presented with an overview 
of the next entities:
Select from the top dropdown menu your cloud account (_per ID_) to filter and observe the different panels,
organized based on different dimensions (users, roles and policies):

1. **Users**: Sysdig provides information based on user activity to compare granted
      permissions with used permissions and remediate them.
2. **Roles**: for every role available, you 
      can learn which policies are attached to it, and its details.
3. **IAM Policies**: Alternatively, you can select the view all the existing policies and,
      from there, click on **Optimize Policy** to modify the policy. The suggestion
      will be based on all users and roles activities.

## Remediation workflow

In the initial page, select one of the users.

1. From here, you can click on **Generate User Specific IAM Policy**
to generate a Least Privilege Policy based on activity for this particular user. 
  Please note that the second option will modify the policy for other users and roles.
2. A new policy will be suggested. Copy this policy and click on **Open user Console**.
3. Create a new policy with it.
4. Attach the policy to the user.


### Alternative workflows

If you select one of the policies from the initial menu,
you can click on **Optimize Policy** to edit the policy based on real usage data,
but also learn about which users had the policy attached (with relevant inormation abou t permissions given vs. unused).



---

TBD: Resource based: S3 and Lambda.
and create activity script

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