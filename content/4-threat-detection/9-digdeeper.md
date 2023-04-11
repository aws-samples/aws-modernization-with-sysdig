---
title: "Dig deeper: Threat Detection"
weight:  99
---

The main tool for Threat Detection and Runtime Security is [Falco](falco.org).

Falco was created by Sysdig in 2016.  It was the first runtime security project to join CNCF as a sandbox-level project, and has since graduated to incubation status.

## Falco and Runtime Security

Link to our internal course in public domain.


## CloudTrail

A set of out-of-the-box Falco rules for CloudTrail is packaged with the Sysdig CloudConnector allowing you to easily generate detections and alerts on abnormal behavior changes. 
You can also complement these with your own custom rules.
The Falco rules are also mapped against **NIST 800-190** compliance standard controls. More compliance mapping for additional compliance standards like PCI or CIS will be provided in the future

### How it works?

Similar to ECS Fargate serverless, incoming CloudTrail events are fetched and stored in an S3 bucket. A subscription in the SNS topic will then forward the events to the **Sysdig CloudVision** endpoint. The CloudVision will then analyze each event against a configured set of **Falco rules**.

![Reference Architecture](/images/50_module_3/image6.png)

Sysdig CloudVision provides several **notification options**, including sending security findings to Sysdig Backend, as well as AWS Security Hub and AWS CloudWatch, so you can review the security events without leaving your AWS console.

![Reference Architecture](/images/50_module_3/image4.png)
