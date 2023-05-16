---
title: "Identifying and Remediating Compliance Requirements"
chapter: true
weight: 1
---


## Identify

Sysdig provides a general overview of your security posture.

Go to Home

Go to Posture > Compliance

## Remediation for CSPM

foo

### Remediation for KSPM

This example will only be available if the EKS and Sysdig agents were deployed.

Go to Posture and select the `CIS Amazon Elastic Kubernetes` benchmark. 
Access the requirement `4.2.1 Minimize the admission of privileged containers`.
This requirement includes the control: `Container running as privileged`.
Click on it, it will present a evaluation displaying all the resources affected by this requirement
and an overview of which ones are failing, passing or ar [accepted]().

![Remediate2](/images/remediate2.png)

The panel present an Automatic remediation workflow and an alternative Manual remediation.
You can configure a Git integration with your repository hosting source files and deploying manifests
for your workloads. With Sysdig IaC Remediation, this workloads will be identified in production and
matched against its definition. Hence, a remeadiation can be applied at its source.
