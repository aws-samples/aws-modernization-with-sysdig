---
title: "EKS Runtime threat detection"
chapter: true
weight: 2
---

Sysdig Secure uses Falco under the hood to deliver Runtime Security
for Linux, containers and Kubernetes.

Hence, all the benefits of the Open Source Ecosystem are available
when protecting workloads in runtime.

In this module you will learn how to detect and respond to
runtime security threats.


![Events](/images/events.png)


## Enable Runtime Security policies and create a custom Policy

1. Visit your Sysdig Secure account to and check that all the 
   `Kubernetes Audit` and `Runtime (Workload)` policies are enabled.
   If not, enable them in the [**Secure > Runtime Policies** dashboard](https://secure.sysdig.com/#/policies?policyTypes=k8s_audit%2Cfalco).

2. In the same menu, click on `Add a Policy`. Select `Workload Policy` type. 
3. Provide a name and a description. In `Policy Rules`, select `Import from Library` and select the rules: `Privileged Shell Spawned Inside Container`, `Terminal shell in container` and `Write below etc`. Then click on `Import rules`.
4. Finally, in the `Actions` section, enable `Captures`. The generated capture will be used for Forensics long after a workload is gone. review the Policy and click on `Save`.



In the next section you will deploy a demo application to generate activity similar to a real attack.