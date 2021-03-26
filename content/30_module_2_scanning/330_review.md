---
title: "Module Review"
chapter: false
weight: 33
---


In this module we saw how to use Sysdig's AWS ECR & ECS/Fargate integrations to automatically scan images at rest in an ECR registry, or deployed.

Firstly we looked at how to setup the Amazon ECR Registry and push images to the it and observe them being scanned. We then deployed an ECS cluster using Fargate and watched as CodeBuild pipelines are automatically created to scan the images.

In each scenario we saw how to view the scan results on the Sysdig Secure dashboard.

In the next module we will look at how Sysdig CloudConnector uses AWS CloudTrail along with Falco to provide runtime protection.
