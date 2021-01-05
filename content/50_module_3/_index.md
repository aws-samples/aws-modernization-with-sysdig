+++
title = "3. CloudTrail Runtime Security"
chapter = true
weight = 50
+++

# Module 3: CloudTrail Runtime Security

## Module Overview

Estimated time to finish module: 30 minutes - 1 hour

Every action taken over your infrastructure resources results in a registry in AWS CloudTrail. This includes all AWS account activity, actions taken through the AWS Management Console, AWS SDKs, command line tools, and other AWS services.  This event history is extremely useful for detecting unwanted or unexpected activity involving your AWS resources, however it's quite noisy, and being JSON, it's not really human readable so can be hard to understand.

Also, as your infrastructure grows and the number of AWS services are released, the amount of events and operational trails can become so huge that analyzing them is no longer practical.  

In this module we will explain how to audit AWS CloudTrail events with Sysdig CloudConnector.  Once deployed in your infrastructure, the Sysdig CloudConnector analyzes every CloudTrail entry in real time, and provides AWS threat detection by evaluating each event against a flexible set of security rules based on Falco. This allows you to detect threats and raise notifications so you can address security threats as quickly as possible.


## Reference Architecture

Similar to ECS Fargate serverless, incoming CloudTrail events are fetched and stored in an S3 bucket. A subscription in the SNS topic will then forward the events to the **Sysdig CloudConnector** endpoint. The CloudConnector will then analyze each event against a configured set of **Falco rules**.

![Reference Architecture](/images/50_module_3/image6.png)

Sysdig CloudConnector provides several **notification options**, including sending security findings to Sysdig Backend, as well as AWS Security Hub and AWS CloudWatch, so you can review the security events without leaving your AWS console.

![Reference Architecture](/images/50_module_3/image4.png)

An important to note is Sysdig remains your single reference point for all infrastructure & runtime security configuration as well as associated events and alerts.
