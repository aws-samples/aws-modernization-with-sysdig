---
title: "Cleanup"
chapter: true
weight: 2
---

{{% notice warning %}}
Uninstalling the Sysdig Agents and the Admission Controller is **not** part of this workshop
(just when the workshop ends), so only follow the steps below if required to do so.
{{% /notice %}}

## Cleanup

To remove the agents for your cluster, you just need to remove the namespace.

```
kubectl delete ns sysdig-agent
```

To remove the agents for your cluster, you just need to remove the namespace.

```
kubectl delete ns sysdig-admission-controller
```

