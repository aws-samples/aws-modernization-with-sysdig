---
title: "Cleanup"
chapter: true
weight: 70
---

## Cleanup

Follow the *Cleanup* steps on each of the different modules. At the end, delete the *Cloud9* instance by:


1. Deleting the `Sysdig-Workshop-Admin` IAM role:

    ```
    aws iam detach-role-policy --role-name Sysdig-Workshop-Admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

    aws iam delete-role --role-name Sysdig-Workshop-Admin
    ```


1. And then removing the *Cloud9 Workstation*:

    ```
    aws cloud9 delete-environment --environment-id $(aws cloud9 list-environments | jq '.environmentIds[]' | xargs)
    ```

{{% notice warning %}}
This action stops the Cloud9 Workspace you are currently working on.
{{% /notice %}}
