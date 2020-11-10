+++
title = "Conclusions"
chapter = true
weight = 60
+++

# Conclusions

{{% children showhidden="false" %}}

There are several **key points** on Sysdig's approach to Amazon ECR and Amazon Fargate image scanning:

 - There is **no need to build specific pipelines for each image.** The scan will be automatically triggered for any workload that is executed in ECS Fargate across your whole infrastructure, or uploaded to ECR.

 - As the container metadata is retained in the Sysdig backend, there is **no need to re-scan the images**. Any update in the vulnerability databases, or any change in your policies, will eventually update the scan reports.

 - The Sysdig backend will act as **a single source of truth** for the security and compliance posture of all your running workloads and container repositories. It centralizes all the security reports and from the same tool, you will also be able to check your compliance status and runtime security events.

Keep in mind that this approach is only part of the solution. You can further strengthen your security and compliance by implementing image scanning in other places of your DevOps lifecycle, like the [CI/CD pipelines](https://sysdig.com/blog/image-scanning-aws-codepipeline-codebuild/) or in the registry. You should also implement other security controls like runtime security, compliance checks, or activity audit. Sysdig helps you [extend security controls all over your AWS container services](https://sysdig.com/blog/aws-container-services-security/) while serving as a single source of truth for the security posture of all your infrastructure.

AWS security can save your infrastructure from failing at its worst moment. It will protect you and your customer data against misconfigurations, a security compromise, or your wallet from unexpected fees.

CloudTrail is a great source of truth, as it can see everything that is happening in your AWS accounts. Leverage Sysdig Secure by deploying Sysdig CloudConnector for CloudTrail and obtaining the runtime visibility you need to implement AWS threat detection. Its out-of-the-box set of Falco rules for CloudTrail minimizes the setup effort, response time, and resources needed for investigating security events.
