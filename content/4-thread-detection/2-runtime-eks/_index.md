---
title: "4.2. EKS Runtime thread detection"
chapter: true
weight: 2
---

TODO:
- better intro
- nice example
- automate example? falco thread generation already running, but not sure if includes syscall activity, recheck!!!!
- workflow with clear sections:
  - detect
  - response


With Sysdig Secure, you can detect and respond to workload threats in AWS.
This means, you'll be able to:
- observe containers, hosts and K8s
based on syscalls activity with a high level of detail.
- use an open source _de-facto_ standard: threat detection based on CNCF project Falco.
- create custom detections using the same Falco syntax
- respond to incidents with detailed captures, even when container workloads are gone from long ago.

In this module you will learn how to trigger, detect and investigate
a runtime security incident. You will also learn how to prevent
issues like this one responding to them as soon as they are detected.


## Rule examples

Let’s take a look at how you can easily apply OOTB rules, ML based detections, 
Drift control, and custom policies to implement a defense in depth with Sysdig.
You can protect your environments using all the default rules based on the Falco project,
and also rules curated by the Sysdig Threat Research Team.

In the [rules section](), observe that you can organize them based on 
security frameworks such as HITRUST, GDPR, NIST, MITRE etc.
You can also filter based on rule source. For example, let’s look at workload rules.
Here we see rules to detect actions commonly used by malicious actors
affecting running workloads such as containers, hosts, and clusters.


If you want to dig deeper, you can access more free training at
the Falco website to [learn more about rules syntax](https://falco.org/training/).


## Enable Runtime Security policies

A policy is a... 

For the next example, enable some required policies:

1. Visit the Runtime Policies section and check that all the 
   `Kubernetes Audit` and `Runtime (Workload)` policies are enabled for this lab.
   If not, enable them in the
   [**Secure > Runtime Policies** dashboard](https://secure.sysdig.com/#/policies?policyTypes=k8s_audit%2Cfalco).

2. Access the policy with the edit button and Enable (Actions> captures). This will be used for Forensics.


 
## Trigger a security event

This demo environment includes the falco-threat generator (installed in the prerequisites section).
Some nefarious activity is being demoed right now in your environment.

In case you want to generate some activity yourself:

1. Go to the terminal and execute the next command:
   
    ```
    kubectl exec -it -n sysdig-agent -- touch /bin/bash
    curl -s https://busybox.net/downloads/binaries/1.21.1/busybox-i686 -o /bin/inject
    ```

## Detect the incident

Go to the events section and observe the security event. WIth Sysdig Secure you can detect Security incidents like privilege Escalation.


## Respond to the incident


<!-- ## Forensics: Review and investigate the incident

1. Visit the [**Secure > Events** dashboard](https://secure.sysdig.com/#/policies?policyTypes=k8s_audit%2Cfalco).
2. From the previous event, click on **Investigate**.
3.  -->


## Kubernetes Audit Logs

The Activity Audit menu allows you to apply further forensics to understand an incident.

Click on the previous detected event and go to its details. Here, click **View Activity Audit**. Here you'll find a time based event feed with all the related activity of the security event. All the related Kubernetes activity is included with the rest of the information.


## Sysdig Inspect

Go back to the event and click on its details. 
From its detials, click on **Respond**, then
**View Capture with Inspect**.

Here you can filter and dig deeper to observe all the syscall activity of the security incident.

<!-- example
it can be extended to cloudtrail
https://blog.christophetd.fr/privilege-escalation-in-aws-elastic-kubernetes-service-eks-by-compromising-the-instance-role-of-worker-nodes/
 -->