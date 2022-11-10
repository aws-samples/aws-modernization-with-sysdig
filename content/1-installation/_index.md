
+++
title = "1. Installation"
chapter = true
weight = 20
+++

{{% notice note %}}
If you do not have a Sysdig account, then you can follow the steps [here](/0-prerequisites/2-sysdig_account.html) to create a free trial Sysdig Account.
{{% /notice %}}


In this first section you will learn:
- how to deploy Sysdig Secure for Cloud
  - with Terraform
  - with CloudFormation
- how to deploy the Sysdig Agents in an EKS Cluster

{{% notice warning %}}
None of these installers enable Fargate Runtime Threat Detection. For this feature, it is required to follow a different installation method (covered in [Module 4.3]((/4-thread-detection/3-fargate.html))).
{{% /notice %}}

## Installation of Sysdig Secure for Cloud

{{% notice info %}}
*Estimated module duration: 5-10 minutes.*
{{% /notice %}}


### Available installers

There are multiple ways to provision **Sysdig Secure for cloud** in AWS:

- [Terraform-based](/1-installation/1-terraform.html)
- [CloudFormation Template (CFT)-based](/1-installation/2-cloudformation.html)

Pick one of the available methods to continue with this workshop. 
We recommend you to follow the Terraform-based method. But following one or the other depends on the user preferences and previous experience with each of the tools (Terraform or AWS CloudFormation).


### What is enabled with this installer?

Important note: this installer enable all the next Sysdig Secure Cloud features:

- Compliance
  - CSPM
- Cloud Threat detection using CloudTrail
- Vulnerability Management
  - ECR Image Registry Scanning
  - Fargate Image Scanning

By default, the Vulnerability Management submodules are not installed,
but here you'll learn how to enable them.


## Installation of Sysdig Agents in an EKS Cluster

{{% notice info %}}
*Estimated module duration: 5-10 minutes.*
{{% /notice %}}


### Available installers

There are [multiple methods](https://docs.sysdig.com/en/docs/installation/sysdig-agent/agent-installation/)
to install the **Sysdig Agents** in a Kubernetes cluster.
In this course a Helm Chart will be used.


### What is enabled with this installer?

With the deployment of the agent in the cluster,
all of the Sysdig Monitor and Secure features are enabled. 

In the particular context of this training, the agents are
required to enable:
- CIEM
- Runtime Thread Detection in EKS
- KSCM: Actionable Compliance and IaC Remediation