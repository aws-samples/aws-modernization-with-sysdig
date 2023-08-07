---
title: "3. Threat Detection"
chapter: true
weight: 57
---

# Module 3: Threat Detection and Response

## Module Overview

In this module you will learn about Threat Detection, this includes:

1. Cloud Runtime Security with CloudTrail (Agentless)
2. Runtime Security with Falco in EKS 
3. Runtime Security in serverless Fargate


## Runtime Threat Detection

After the image scanning is done, you might think that all the work is completed and your application is safe to be deployed and used.

Reality is that not all vulnerabilities are known and indexed in a vulnerability database
(remember this is part of [how image scanning works](/2-vulnerability-management/9-digdeeper.html)). But there are ways to reduce this risk: enter Runtime Security.

With Runtime Security you can stay safe against 
zero-day vulnerabilities, but also agains threats harder to detect like file access (data leaks) or
privilege escalation attempts.

Runtime Security can be applied to cloud, Linux, containers, Kubernetes and serverless workloads like **Fargate**.

In this module you will learn about Falco. 
Falco is an open source threat detection language that is widely used to detect and alert on runtime abnormalities, and can also be used to detect changes within the AWS environment.


## Cloud Threat Detection

![Runtime Policies](/images/40_module_2/cdr-solution.png)

Sysdig CDR (Cloud Detection and Response) built on top of Falco, detects and alerts on AWS events and changes.  This makes Sysdig Secure your central location to detect and alert on any suspicious event happening anywhere in your infrastructure including cloud applications and services.

AWS provides a rich environment upon which to base your application, but it's not without its risks.  There are many places where bad actors can create harm, for example exposing data by making S3 buckets public, deleting bucket encryption, disabling MFA for an account, adding/removing IAM policies.

Every action taken over your infrastructure resources results in an entry in AWS CloudTrail. This includes all AWS account activity, actions taken through the AWS Management Console, AWS SDKs, command line tools, and other AWS services.  This event history is extremely useful for detecting unwanted or unexpected activity involving your AWS resources, however it's quite noisy, and being JSON, it's not really human readable so can be hard to understand.

Sysdig performs threat detection using Falco rules and policies on CloudTrail events. (It creates a CloudTrail trail in the account(s), the agentless feature relies on AWS EventBridge to access AWS service events).




