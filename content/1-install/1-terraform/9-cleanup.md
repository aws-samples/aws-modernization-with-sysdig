---
title: "Cleanup"
chapter: true
weight: 2
---

{{% notice warning %}}
Uninstalling Sysdig Secure for cloud is **not** part of this workshop (just when the workshop ends), so only follow the steps below if required to do so.
{{% /notice %}}

## Cleanup

Should you wish to uninstall Sysdig Secure for cloud from your account, then follow the steps below:

1. `cd` into the directory with the TF state.
2. And execute:

    ```
    cd tf-sysdig-secure-cloud
    terraform destroy --auto-approve
    ```