---
title: "Module Review"
chapter: false
weight: 45
---

In this module we saw how to use Sysdig's AWS ECS/Fargate integration to automatically scan deployed images.

We first deployed Sysdig's AWS ECS/Fargate integration using a CloudFormation template.

In particular we looked at how to deploy the Amazon ECR Integration. Then we deployed an ECS cluster using Fargate and watched as CodeBuild pipelines are automatically created to scan the images.

Finally we saw how to view the scan results on the Sysdig Secure dashboard.

In the next module we will look at how Sysdig CloudConnector uses AWS CloudTrail along with Falco to provide runtime protection. 
