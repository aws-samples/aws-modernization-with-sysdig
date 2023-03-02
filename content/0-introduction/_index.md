---
title: "Introduction"
chapter: false
weight: 1
---

# To Cloud Security Platforms
## A new paradigm for security platforms

Before describing the Sysdig platform, it is good to get an overview of the new
categories for modern IT security tools that are emerging ³ for cloud.

![Cloud Security Platforms](/images/00_introduction/cloudplatforms.png)

- **Cloud Workloads protection platform (CWPP)**: This segment might look like a dropbox
  category with a set of heterogeneus tools. But they all share a common goal:
  workload protection in its different stages. It includes:
    - Runtime Detection
    - System hardening
    - Vulnerability Management
    - Network Security
    - Compliance
    - Incident Response

- **Cloud Security Posture Management (CSPM)**: security in cloud environments is not all about the workloads.
  The cloud where the workloads are running also need to be protected by the final user.
  This tools are designed to identify misconfiguration issues and compliance risks in the cloud.
  Tracking cloud resources and verifying the static configuration of the cloud is the main goal of these tools.
  Some CSPM solutions will add extended capabilities, like providing remediation.
  Also, one of the main use cases of CSPM is to check that cloud settings are following best practices.

- **Cloud infrastructure entitlement management (CIEM)**: in cloud environments, human and non-human 
  identities can access access different resources. To apply a Principle of least privilege,
  administrators need to learn which permissions are being used on a daily basis and which ones not.
  And hence, suggest policy modifications to enforce least privilege access.

- **Cloud-native application protection platform (CNAPP)**: it provides more than CWPP-CSPM convergence.
  CNAPP integrates CSPM and CWPP to offer both, and potentially augments them
  with additional cloud security capabilities, like Infrastructure as Code Scanning,
  extended monitoring capabilities and more.

In this scenario, it is easy to find tools targeted to an specific security area,
with no real support work with other tools. Some customers decide to approach cloud
security with different tools to cover all the different use cases.
But this lack of integration might have negative consequences.

Sysdig provides an integral approach to continuos cloud security,
targeting at all of the to the whole spectrum of security threats.

![Sysdig](/images/logo.png)


# Sysdig Secure for AWS

Sysdig is driving the standard for cloud and container security and helping enterprises confidently run containers,
Kubernetes, and cloud services. With the Sysdig platform, you can find and prioritize software vulnerabilities,
detect and respond to threats, and manage cloud configurations, permissions, and compliance. 

From containers and Kubernetes running with solutions like Amazon ECS, Amazon EKS, and AWS Fargate,
to your AWS cloud services such as Amazon S3, Amazon RDS, and AWS Lambda, you get a single view of risk from source to run.

By providing real-time visibility at scale, Sysdig helps you address risk and eliminate
security blind spots across your entire cloud and container environment. 

The following section provides an overview of the modules covered in this workshop
as well as guidance on expected costs if you run the workshop in your own AWS account.


## Workshop Modules

There are no dependencies between modules.
The first two modules _Prerequisites_ and _1. Install_ are required to complete the rest of the modules.
Except of the _4.3 Fargate_ module, that does not require to follow the installation steps in _1. Install_.

Module | Submodule | Use-case | Description | ETA
------------ | ------------ | ------------- | ------------- | -------------
[Prerequisites](../../0-prerequisites.html) | | Workshop setup | Prerequisites to setup the workshop. | 20 min.
[1. Install](../../1-install.html) | Terraform | Deploy Sysdig Secure for Cloud | Deploy the Sysdig Stack to secure your AWS workloads | 10 min.
&nbsp; | CloudFormation | Deploy Sysdig Secure for Cloud | Deploy the Sysdig Stack to secure your AWS workloads | 10 min.
&nbsp; | Sysdig Agents | Deploy Sysdig Secure for k8s Workloads | Deploy Sysdig Agents in EKS | 10 min.
[2. Vulnerability Management](../../2-vulnerability-management.html) | ECR Registry Scanning | Scan images from ECR automatically | Scan your ECR Registry images automatically | 20 min.
[3. Security Posture](../../3-posture.html) | CSPM | Cloud Security Posture Management | Insights, Benchmarks and Compliance | 15 min.
[4. Threat Detection](../../4-thread-detection.html) | CloudTrail | Runtime Cloud Security | Protect your cloud environments at runtime. | 10 min.
&nbsp; | EKS | Runtime Security for EKS | Protect your AWS Managed k8s from runtime threats. | 15 min.
&nbsp; | Fargate | Runfime Security for Fargate | Serverless Runtime Protection | 20 min.

If you run out of time in the workshop, don't panic! 
These instructions are public and they are available after your workshop ends.


## Workshop Cost

If you are using an account provided at an AWS event, the account will be cleaned up automatically. There are no AWS costs for you in this case.

If you are using your own AWS account, it may incur some costs. 
To minimize cost, make sure you deprovision and delete those resources when you are finished. 
You can find the instructions for how to do that under the Cleanup section under each different module.

---

³ Alba Ferri (Sysdig), 2021. [_CSPM, CIEM, CWPP, and CNAPP: Guess who in cloud security landscape_](https://sysdig.com/blog/cnapp-cloud-security-sysdig/).