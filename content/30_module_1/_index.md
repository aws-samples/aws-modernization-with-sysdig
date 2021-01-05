+++
title = "1. ECR Automated Image Scanning"
chapter = true
weight = 30
+++

# Module 1: ECR Automated Image Scanning

## Overview

Estimated time to finish module: 30 minutes - 1 hour

Amazon Elastic Container Registry (ECR) is a fully-managed Docker container registry that makes it easy for developers to store, manage, and deploy Docker container images. It hosts your container images in a highly available and scalable architecture, allowing you to reliably deploy containers for your applications.  Sysdig provides inline scanning of your Amazon ECR registry as part of Sysdig's ImageVision.  

In this lab we will:

1. Setup the Amazon ECR Registry
2. Deploy the Amazon ECR Integration
3. Push and scan an image from the registry
4. See scan results on Sysdig Secure dashboard
5. Download example Dockerfile and sources
6. Modify the image and trigger a second scan

## Reference Architecture

Enabling Amazon ECR Image Scanning is as simple as deploying a single CloudFormation template, and once deployed, all images that are pushed to the registry will be automatically scanned within your AWS account.

How this is implemented is illustrated below.

![Reference Architecture](/images/30_module_1/arch.png)

Once a new image is pushed to Amazon ECR, this is picked up by Amazon EventBridge and passed to a Lambda function which creates an ephemeral CodeBuild task to build and scan the base image.  The results of the scan are then sent to the Sysdig Secure backend.  You are not required to configure, or expose, the registry on the Sysdig Secure side. Also, the image itself is not sent to Sysdig, but only the image metadata.

An important point to note is that, although the scan actually happens with this AWS pipeline, you maintain the scanning policies and view results within Sysdig.

#### About AWS CodeBuild
[AWS CodeBuild](https://aws.amazon.com/codebuild/) is a fully managed continuous integration service. CodeBuild compiles source code, runs tests, and produces deployable software packages without the need to provision, manage, and scale your own build servers.

The ephemeral task that is created for scanning our images is important to note because AWS CodeBuild allows you to do two important steps as part of the image build process:

1. AWS CodeBuild lets you use custom containers or choose standard images provided by AWS which in this case is used to scan our container images
2. AWS CodeBuild builds the base image for your container as we need an ephemeral container that is responsible for scanning the image built for security vulnerabilities. 
