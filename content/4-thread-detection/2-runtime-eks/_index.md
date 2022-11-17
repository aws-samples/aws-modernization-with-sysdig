---
title: "4.2. EKS Runtime thread detection"
chapter: true
weight: 2
---

Sysdig Secure uses Falco under the hood to deliver Runtime Security
for Linux, containers and Kubernetes.

Hence, all the benefits of the Open Source Ecosystem are available
when protecting workloads in runtime.

In this module you will learn how to trigger, detect and investigate
a runtime security incident. You will also learn how to prevent
issues like this one responding to them as soon as they are detected.


## Enable Runtime Security policies

What are rules?
Link to Falco course on rules.

What are Runtime Policies?


1. Visit your Sysdig Secure account to and check that all the 
   `Kubernetes Audit` and `Runtime (Workload)` policies are enabled.
   If not, enable them in the [**Secure > Runtime Policies** dashboard](https://secure.sysdig.com/#/policies?policyTypes=k8s_audit%2Cfalco).

2. Enable captures for policy X. This will be used for Forensics.


## Trigger a security event

1. Go back to your terminal and execute the next command:
   
    ```
    kubectl exec -it -n sysdig-agent -- touch /bin/bash
    ```

2. From there, create a new binary:
   
    ```
    curl -s https://busybox.net/downloads/binaries/1.21.1/busybox-i686 -o /bin/inject
    ```
4. asdf


## Forensics: Review and investigate the incident

1. Visit the [**Secure > Events** dashboard](https://secure.sysdig.com/#/policies?policyTypes=k8s_audit%2Cfalco).
2. From the previous event, click on **Investigate**.
3. 


## Kubernetes Audit Logs

The Activity Audit menu allows you to apply further forensics to understand an incident.

Events from K8s audit logs: https://docs.sysdig.com/en/docs/sysdig-secure/secure-events/kubernetes-audit-logging/


## Sysdig Inspect


<!-- example
it can be extended to cloudtrail
https://blog.christophetd.fr/privilege-escalation-in-aws-elastic-kubernetes-service-eks-by-compromising-the-instance-role-of-worker-nodes/
 -->