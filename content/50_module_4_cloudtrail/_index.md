+++
title = "4. Threat Detection"
chapter = true
weight = 50
+++

# Module 4: Threat Detection based on CloudTrail

## Module Overview

Estimated time to finish module: 30 minutes - 1 hour

Every action taken over your infrastructure resources results in an entry in AWS CloudTrail. This includes all AWS account activity, actions taken through the AWS Management Console, AWS SDKs, command line tools, and other AWS services.  This event history is extremely useful for detecting unwanted or unexpected activity involving your AWS resources, however it's quite noisy, and being JSON, it's not really human readable so can be hard to understand.

Also, as your infrastructure grows and the number of AWS services are released, the amount of events and operational trails can become so huge that analyzing them is no longer practical.  

In this module we will explain how to audit AWS CloudTrail events with Sysdig.  Once Sysdig Secure for cloud is deployed in your infrastructure, every CloudTrail entry is analysed in real time, and evaluated against a flexible set of security rules based on Falco.

This allows you to detect misconfigurations and unexpected or unwanted activity quickly and raise notifications when something, or someone, creates, deletes or modifies your cloud resources, hence protecting you from compromised cloud accounts or involuntary human error.

A rich set of Falco rules are included corresponding to security standards and benchmarks like NIST 800-53, PCI DSS, SOC 2, MITRE ATT&CK®, CIS AWS, AWS Foundational Security Best Practices.


## Reference Architecture

Similar to ECS Fargate serverless, incoming CloudTrail events are fetched and stored in an S3 bucket. A subscription in the SNS topic will then forward the events to the **Sysdig CloudConnector** endpoint. The CloudConnector will then analyze each event against a configured set of **Falco rules**.

![Reference Architecture](/images/50_module_3/image6.png)

Sysdig CloudConnector provides several **notification options**, including sending security findings to Sysdig Backend, as well as AWS Security Hub and AWS CloudWatch, so you can review the security events without leaving your AWS console.

![Reference Architecture](/images/50_module_3/image4.png)

An important to note is Sysdig remains your single reference point for all infrastructure & runtime security configuration as well as associated events and alerts.
