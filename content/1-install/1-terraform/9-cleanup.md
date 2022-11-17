---
title: "Cleanup"
chapter: true
weight: 2
---

## Cleanup

Should you wish to uninstall Sysdig Secure for cloud from your account, then follow the steps below.

{{% notice warning %}}
Uninstalling Sysdig Secure for cloud is **not** part of this workshop (just when the workshop ends), so only follow the steps below if required to do so.
{{% /notice %}}

To uninstall it:

1. `cd` into the directory with the TF state.
2. And execute:

    ```
    terraform destroy --auto-approve
    ```