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
