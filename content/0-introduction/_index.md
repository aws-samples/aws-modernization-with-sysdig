---
title: "Introduction"
chapter: false
weight: 1
---

# TO CLOUD NATIVE APPLICATION PROTECTION PLATFORMS

The cloud has fundamentally changed the nature of modern applications, IT infrastructures, and processes. Cloud infrastructures provide the dynamic building blocks that allow development teams to rapidly spin up software and continuously deliver solutions to meet evolving customer and market needs.
Modern applications built on open software supply chains, microservices, and cloud support business innovation but also create a dynamic and growing attack surface of interdependent workloads, services, and identities. 
To keep pace, cloud users are increasingly looking for a consolidated platform that addresses four functional requirements: 

- Vulnerability management
- Posture management
- Permissions & entitlement management
- Threat detection & response

To boost effectiveness, organizations are adopting Cloud Native Application Protection Platforms (CNAPPs), like Sysdig, that combine functionality for Cloud Security Posture Management (CSPM), Cloud Workload Protection (CWP), Cloud Infrastructure Entitlement Management (CIEM), and Cloud Detection and Response (CDR) into one platform. By integrating these capabilities teams are able to avoid disconnects that occur with point solutions to manage risk without slowing down application delivery.

![Cloud Security Platforms](/images/00_introduction/cloudplatforms.png)

![Sysdig](/images/logo.png)


# Sysdig Secure for AWS

Sysdig helps companies secure and accelerate innovation in the cloud. Our roots are in runtime security built on Falco, the open standard for cloud threat detection created by Sysdig. Powered by Runtime Insights, our platform helps developers, DevOps, DevSecOps, and security teams understand what is running in production to focus on the risks that matter most.

Using Sysdig, you’ll be able to detect and stop attacks in real time, prioritize and fix vulnerabilities fast, reduce cloud security posture risk, and more effectively manage permissions.

In this workshop, you’ll experience how to implement cloud-native security for containers and Kubernetes with AWS solutions like Amazon Elastic Container Service (ECS), Amazon Elastic Kubernetes Service (EKS), and AWS Fargate, as well as manage and remediate misconfigurations with AWS cloud services such as Amazon S3, Amazon RDS, and AWS Lambda.


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
[4. Threat Detection](../../4-threat-detection.html) | CloudTrail | Runtime Cloud Security | Protect your cloud environments at runtime. | 10 min.
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
