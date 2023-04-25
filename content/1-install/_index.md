---
title: "1. Install"
chapter: true
weight: 20
---

{{% notice info %}}
None of these installers enable Fargate Runtime Threat Detection. For this feature, it is required to follow a different installation method (covered in [Module 4.3](/4-threat-detection/3-fargate.html)).
{{% /notice %}}

In this first section you will learn:
1. How to deploy Sysdig Secure for Cloud. There are two alternative methods:

     - [with Terraform](/1-install/1-terraform.html).
     - [with CloudFormation](/1-install/2-cloudFormation.html).

2. How to [deploy the Sysdig Agents with Helm](/1-install/3-agent-eks.html) in an EKS Cluster.
  There are [multiple methods](https://docs.sysdig.com/en/docs/installation/sysdig-agent/agent-installation/) to install a Sysdig Agent that are not covered in this workshop.

    {{% notice note %}}
For the Cloud installers (Terraform and CloudFormation) choose just one of the available methods to continue with this workshop. 
Following one or the other depends on the user preferences
and previous experience with each of the tools.
{{% /notice %}}

## Features enabled by each installer

1. The **Sysdig Secure for Cloud** installer will enable 
   all the next Sysdig Secure Cloud features:

      - Compliance
      - CSPM
      - Cloud Threat detection using CloudTrail
      - Vulnerability Management
      - ECR Image Registry Scanning
      - Fargate Image Scanning


2. The deployment of the **Sysdig Agents in an EKS cluster**,
  enable most of the Sysdig Monitor and Secure features. 
  In the particular context of this training, the agents are required to enable:

      - CIEM
      - Runtime Threat Detection in EKS
      - KSCM: Actionable Compliance and IaC Remediation
      - **Kubernetes Admission Controller** for cluster Audit logging in EKS
