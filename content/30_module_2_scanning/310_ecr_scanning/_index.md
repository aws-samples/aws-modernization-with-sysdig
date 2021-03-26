---
title: "1. ECR Image Scanning"
chapter: true
weight: 30
---

# ECR Automated Image Scanning

## Overview

<!-- Estimated time to finish module: 30 minutes - 1 hour -->

Amazon Elastic Container Registry (ECR) is a fully-managed container registry that makes it easy for developers to store, manage, and deploy container images. It hosts your container images in a highly available and scalable architecture, allowing you to reliably deploy containers for your applications.  

In this lab we will:

1. Setup the Amazon ECR Registry
1. Push and scan an image from the registry
1. See scan results on Sysdig Secure dashboard
1. Download example Dockerfile and sources
1. Modify the image and trigger a second scan

<!-- ## ECR Automated Image Scanning Reference Architecture

Once Amazon ECR Image Scanning is deployed (via the Sysdig Secure for cloud CloudFormation template), all images that are pushed to the registry will be automatically scanned within your AWS account.

How this is implemented is illustrated below.

![Reference Architecture](/images/30_module_1/arch.png)

Once a new image is pushed to Amazon ECR, this is picked up by Amazon EventBridge and passed to a Lambda function which creates an ephemeral CodeBuild task to build and scan the base image.  The results of the scan are then sent to the Sysdig Secure backend.  You are not required to configure, or expose, the registry on the Sysdig Secure side. Also, the image itself is not sent to Sysdig, but only the image metadata.

An important point to note is that, although the scan actually happens with this AWS pipeline, you maintain the scanning policies and view results within Sysdig.
<!--
#### About AWS CodeBuild -->
<!-- [AWS CodeBuild](https://aws.amazon.com/codebuild/) is a fully managed continuous integration service. CodeBuild compiles source code, runs tests, and produces deployable software packages without the need to provision, manage, and scale your own build servers. -->

<!-- The ephemeral task that is created for scanning our images is important to note because AWS CodeBuild allows you to do two important steps as part of the image build process:

1. AWS CodeBuild lets you use custom containers or choose standard images provided by AWS which in this case is used to scan our container images
2. AWS CodeBuild builds the base image for your container as we need an ephemeral container that is responsible for scanning the image built for security vulnerabilities. -->

<!-- CodeBuild creates ephemeral tasks for scanning our images for security vulnerabilities as part of the image build process. It lets you use custom containers or choose standard images provided by AWS.  

The Sysdig Secure for cloud deployment will create a new **Amazon CloudBuild** project that will automatically scan container images pushed to ECR registries. -->

<!-- To view your Amazon CloudBuild projects, browse to [Developer Tools > CodeBuild](https://console.aws.amazon.com/codesuite/codebuild/projects?region=us-east-1) ![ECR](/images/30_module_1/codebuild.png) -->