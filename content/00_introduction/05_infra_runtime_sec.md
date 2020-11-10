---
title: "Infrastructure Runtime Security"
draft: false
weight: 05
---

In the same way image scanning gives you visibility of vulnerabilities and threats pertaining specifically to an application's containers, infrastructure scanning gives visibility of potential issues emanating from the environment on which these containers run.

AWS provides a rich environment upon which to base your application, but it's not without its risks.  There are many places where bad actors can create harm, for example exposing data by making S3 buckets public, deleting bucket encryption, disabling MFA for an account, adding/removing IAM policies.

Falco is an open source threat detection language that is widely used to detect and alert on runtime abnormalities, and can also be used to detect changes within the AWS environment.

Falco was created by Sysdig in 2016 and is the first runtime security project to join CNCF as an incubation-level project.

A set of out-of-the-box Falco rules for CloudTrail is packaged with the Sysdig CloudConnector allowing you to easily generate detections and alerts on abnormal behavior changes. The included out-of-the-box CloudTrail rules can detect events like:

*   Add an AWS user to a group.
*   Allocate a New Elastic IP Address to AWS Account.
*   Attach an Administrator Policy.
*   Create an AWS user.
*   Deactivate MFA for user access.
*   Delete bucket encryption.

You can also complement these with your own custom rules.

The Falco rules are also mapped against **NIST 800-190** compliance standard controls. More compliance mapping for additional compliance standards like PCI or CIS will be provided in the future

Using Falco to detect and alert on AWS configuration changes is similar to runtime detections of your application stack.  This makes Sysdig Secure your central location to detect and alert on all aspects of your security posture.
