+++
title = "Amazon ECS & Fargate Security"
chapter = true
weight = 40
+++

# Module 2: Fargate automatic image scanning

## Module Overview

Amazon Fargate is a serverless compute engine for containers that works with both Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes Service (EKS). It allocates the correct amount of compute resources, eliminating the need to choose instance types and scaling cluster capacity. With Fargate, you pay for the minimum resources required to run your containers.  Sysdig provides the ability to scan running Fargate services for known issues, in a similar manner to how it scans Amazon ECR.

In this lab we will

1. Install Amazon ECS CLI
2. Deploy Sysdig Secure automatic image scanner for Fargate
3. Deploy an ECS cluster using Fargate
4. See that CodeBuild pipelines are automatically created to scan them
5. See scan results on Sysdig Secure dashboard

## Reference Architecture

Any **deploy command** directed at ECS Fargate will trigger an **image scanning** event. In particular the deploy command is detected by Amazon EventBridge, which will trigger a CodeBuild pipeline via an AWS Lambda function. It is within this CodeBuild pipeline that the image scanning runs. This is very similar workflow to how we seen earlier with Amazon ECR scanning.

![Reference Architecture](/images/40_module_2/image2.png "image_tooltip")

The Sysdig inline image scanner will inspect the image to be deployed and will send its metadata to the Sysdig backend. The actual image contents won't leave the CodeBuild pipeline.

![alt_text](/images/40_module_2/image13.png "image_tooltip")

The Sysdig backend then **evaluates** the container metadata against your security policies. It will generate a **scan report** if the image doesn't pass your security requirements, so you can **take action**.
