---
title: "1. Install"
chapter: true
weight: 20
---

{{% notice info %}}
None of these installers enable Fargate Runtime Threat Detection. For this feature, it is required to follow a different installation method (covered in [Module 4.3](/4-thread-detection/3-fargate.html)).
{{% /notice %}}

In this first section you will learn:
- How to deploy Sysdig Secure for Cloud
  - [with Terraform](/1-install/1-terraform.html)
  - [with CloudFormation](/1-install/2-cloudFormation.html)

    {{% notice note %}}
Pick one of the available methods to continue with this workshop. 
But following one or the other depends on the user preferences
and previous experience with each of the tools (Terraform or AWS CloudFormation).
{{% /notice %}}

- How to [deploy the Sysdig Agents and the Sysdig Admission Controller with Helm](/1-install/3-agent-eks.html) in an EKS Cluster
  (there are multiple methods to install a Sysdig Agent that are not covered in this workshop,
  check the [docs to learn more about them](https://docs.sysdig.com/en/docs/installation/sysdig-agent/agent-installation/).





## Features enabled by each installer

1. The Sysdig Secure for Cloud installer will enable 
   all the next Sysdig Secure Cloud features:

      - Compliance
      - CSPM
      - Cloud Threat detection using CloudTrail
      - Vulnerability Management
      - ECR Image Registry Scanning
      - Fargate Image Scanning


2. The deployment of the Sysdig Agents in the EKS cluster,
  enable most of the Sysdig Monitor and Secure features. 
  In the particular context of this training, the agents are required to enable:

      - CIEM
      - Runtime Thread Detection in EKS
      - KSCM: Actionable Compliance and IaC Remediation

3. The admission controller is used in this workshop
   to get the Kubernetes Audit logs from the EKS cluster.