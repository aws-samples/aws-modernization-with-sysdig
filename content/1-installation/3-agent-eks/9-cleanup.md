
+++
title = "Cleanup"
chapter = true
weight = 2
+++

## Cleanup

To remove the agents for your cluster, you just need to remove the namespace.

```
kubectl delete ns sysdig-agent
```

{{% notice warning %}}
Uninstalling the Sysdig Agents is **not** part of this workshop (just when the workshop ends), so only follow the steps below if required to do so.
{{% /notice %}}