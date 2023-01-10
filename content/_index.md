---
title: "Sysdig Secure for AWS"
chapter: false
weight: 1
---
<!-- this is the HOME LANDING PAGE https://sysdig.awsworkshop.io/ 
Instead of using this to introduce Sysdig Platform,
this is a intro to the workshop:
- what are cloud native applications
- Intro to the workshop
- Objectives
- Audience
- Duration
- -->

![Sysdig](/images/logo.png)


# Sysdig Secure for AWS

Welcomed to this workshop!

If you are here, you are aware about some of
the challenges of securing _cloud-native_ applications.


## Nature of _Cloud-Native_ applications

Securing _Cloud-Native_ applications is not an easy duty, even for professionals.
Part of this complexity can be explained by a set of unique attributes ¹. These applications typically are:

- A combination of microservices applications (often based on Linux containers).
- Built using rapid DevOps-style development practices.
- Automatically deployed onto programmatic cloud infrastructure.
- A heterogeneous set of workloads (containers, serverless, VMs) running on public clouds and/or on-premises.
- Owned by multiple teams: DevOps, Security Operations, Developers. All are responsible of the management (monitoring and security) of infrastructure, but also of workloads and applications.

Adding to this, most of the workloads are ephemeral and their lifespan is short
(44% of the conteiners run in production live less than 5 minutes ²).
All of these make evident that Cloud-Native applications require 
an integrated approach to security that the _good old_ security tools can not provide.


## Introduction to the workshop

This workshop will provide you with a holistic view of continuous cloud and workload security;
from development to runtime.
During the next 2-3 hours, you will learn about key security concepts, supplemented with
insights and real scenarios where you will practice how to protect modern cloud applications.

Although this workshop approaches security from a Sysdig-*centric* perspective,
the concepts and practice included will be useful for
anyone interested in learning how to secure cloud assets and workloads.


## Objectives

_Here you can find a [detailed table with all of the contents](/0-introduction.html)_.

In this workshop, you will learn how Sysdig Secure for cloud gives you 
**a unified Cloud Security Platform** that provides you with a complete suite for 
_Asset Discovery, Cloud Security Posture Management and Compliance,
Vulnerability Scanning_ and _Threat Detection_ for all your cloud accounts.


The main goal of the workshop is to introduce the student
to key concepts of cloud and workload security.
In particular, the student will learn how to install, configure and use
the following Sysdig Secure features available today for AWS:

- Vulnerability Management
   - AWS ECR Image Registry Scanning
 - Security Posture:
   - Cloud Security Posture Management (_CSPM_), including _CIS AWS Benchmark compliance_
   - Kubernetes Security Posture Management (_KSPM_)
     - Infrastructure as Code (_IaC_) remediation
   - Cloud Infrastructure Entitlements Management (_CIEM_)
 - Threat Detection:
   - Cloud Thread Detection based on _CloudTrail_
   - _EKS_ Runtime Threat Detection based on [_Falco_](https://falco.org/)
   - _Fargate_ Serverless Runtime Threat Detection

For a detailed description of these Sysdig Secure for cloud integrations with AWS,
please refer to the [Sysdig Secure for cloud documentation](https://docs.sysdig.com/en/docs/sysdig-secure/sysdig-secure-for-cloud/aws).

![Sysdig Secure for cloud overview](/images/cloudvision.png)


## Audience: _Who can take this workshop_?

_Everybody_. This workshop is designed for anyone who might want
to learn about Cloud and Workload Security,
and it can be completed with little or no prior experience. 
However, it is specifically aimed at:

- DevOps Engineers
- Software Developers
- Site Reliability Engineers (SREs)
- Security Architects


Some experience with AWS is helpful but the workshop will provide instructions
to help you run through the workshop.
If you are attending one of our live workshop sessions there will be helpers
to assist you with any issues you encounter.


## Expected Duration:

_2-3 Hours_. For a detailed time estimation per module, visit the [modules section](/0-introduction.html).

---

¹ Gartner, 2021. [_Innovation Insight for Cloud_Native Application Protection Platforms_](https://www.gartner.com/en/documents/4005115).

² Sysdig, 2022. [_Cloud_Native Security and Usage Report_](https://sysdig.com/2022-cloud-native-security-and-usage-report/).
