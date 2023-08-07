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


# CLOUD SECURITY POWERED BY RUNTIME INSIGHTS WITH SYSDIG

Welcomed to the Sysdig and AWS workshop!

If you are here, you are likely aware of the challenges of providing security in the cloud.


## Key Challenges of Securing the Cloud

The shift to cloud and container technologies has introduced a new set of challenges in terms of security. Traditional solutions are inadequate for handling the dynamic nature of cloud workloads, environment complexity, and new abstractions.  

Securing cloud-native applications and infrastructure is not easy, even for professionals. 


### What are the common challenges?
- Dynamic workloads using a combination of cloud services, VMs, microservices, and applications built inside containers. How can you track activity in real time to keep up with threats?
- Rapid code development using CI/CD development practices increases the risk of vulnerabilities entering production. How do you prioritize issues without slowing innovation? 
- Multiple teams – Developers, DevOps, Security – are responsible for the management, monitoring, and security of infrastructure, applications, and cloud services. How do you eliminate silos and enable collaboration? 
- At scale, large volumes of dynamic cloud assets, configurations, and permissions spanning public and on-premises infrastructure are difficult to manage. How can you get a single view of risk across all workloads and cloud deployments?
- Workloads are ephemeral with short lifespans – 72% of containers live less than five minutes. How do you detect and respond to threats in real-time?


## About the Workshop

This workshop will provide you with a holistic view of continuous cloud and workload security from development to runtime. During the next 2-3 hours, you will learn about key security concepts, supplemented with insights and real-world scenarios where you will be able to practice how to protect modern cloud applications.

Although this workshop approaches security from a Sysdig-centric perspective, the concepts and practices included are useful for anyone interested in learning how to secure cloud services and containers.


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
   - Cloud Infrastructure Entitlements Management (_CIEM_)
 - Threat Detection:
   - Cloud Threat Detection based on _CloudTrail_
   - _EKS_ Runtime Threat Detection based on [_Falco_](https://falco.org/)
   - _Fargate_ Serverless Runtime Threat Detection

For a detailed description of these Sysdig Secure for cloud integrations with AWS,
please refer to the [Sysdig Secure for cloud documentation](https://docs.sysdig.com/en/docs/sysdig-secure/sysdig-secure-for-cloud/aws).

![Sysdig Secure for cloud overview](/images/sysdig-cnapp.png)


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

<!-- ---

¹ Gartner, 2021. [_Innovation Insight for Cloud_Native Application Protection Platforms_](https://www.gartner.com/en/documents/4005115).

² Sysdig, 2022. [_Cloud_Native Security and Usage Report_](https://sysdig.com/2022-cloud-native-security-and-usage-report/). -->
