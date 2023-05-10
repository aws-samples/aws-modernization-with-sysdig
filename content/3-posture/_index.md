---
title: "3. Posture"
chapter: true
weight: 40
---


{{% notice info %}}
The new Actionable Compliance views have been recently released and are not generally available.
This workshop includes the previous version of Compliance and will be updated with the latests updates soon.
Contact your Sysdig representative to learn more about this features.
{{% /notice %}}



## About this module

In this module, you will learn about Security Posture and Compliance. 

You will use Sysdig Secure to get an overview of your Cloud security posture and will take action to remediate a couple of detected issues. 

<!-- You will also use the *IaC Security* feature to automatically fix one posture issue with the new Sysdig Secure integration with GitHub. -->


## Intro to posture

Security Posture is a wide term used to describe 
what's the security status of key assets of a company: workloads, cloud resources, permissions, etc.

Most of the tools available provides a set of controls to check,
but no actions or remediation steps to fix the issue.
Sysdig Secure Actionable Compliance is able to detect posture issues and remediate them immediately.

Adding to this, Sysdig Compliance includes the next set of features:

- No event-based. There's no need for a security incident to happen to fetch the data. Relevant APIs are fetched periodically to retrieve the latest data to evaluate your security posture status.
- Sysdig AC persists the resources in its backend, and fetch it at regular intervals. This means that there's no need to reevaluate the compliance status of a given resource when there are changes in a benchmark.


## Terminology

The Sysdig Docs provides a [glossary of relevant terminology](https://docs.sysdig.com/en/docs/sysdig-secure/posture/compliance/actionable-compliance/#appendix) to Actionable Compliance terms that is recommended to review before continuing.


