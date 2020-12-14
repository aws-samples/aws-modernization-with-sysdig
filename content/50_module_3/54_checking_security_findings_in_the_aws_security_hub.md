---
title: "Checking Security Findings in AWS Security Hub"
chapter: false
weight: 54
---

You can check these events without leaving the AWS console. This is how findings reported by Sysdig CloudConnector look in the AWS Security Hub:

1. Browse to [Security Hub](https://console.aws.amazon.com/securityhub/home) and click 'Findings' on the left.


  ![AWS Security Hub](/images/50_module_3/image5.png)

2. Click on "Delete bucket encryption" to view all the information you need to take immediate action:

  ![Delete Encryption](/images/50_module_3/image2.png)


3. And they appear in JSON format in AWS CloudWatch log streams.

    Browse to [CloudWatch](https://console.aws.amazon.com/cloudwatch/), and click 'Log groups > cloud-connector > alerts'

    ![AWS CloudWatch Log Streams](/images/50_module_3/image1.png)

Further, these events can be forwarded to the Sysdig Backend, and alerted upon as necessary in your normal channels.
