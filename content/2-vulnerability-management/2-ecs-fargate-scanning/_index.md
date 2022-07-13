+++
title = "2. Fargate & ECS Image Scanning"
chapter = true
weight = 30
+++

# Fargate & ECS Automated Image Scanning

## Overview

Amazon Elastic Container Service (Amazon ECS) is a fully managed container orchestration service.

AWS Fargate is a serverless compute engine for containers that works with Amazon ECS. Fargate makes it easy for you to focus on building your applications by removing the need to provision and manage servers, lets you specify and pay for resources per application, and improves security through application isolation by design.

<!-- Estimated time to finish module: 30 minutes - 1 hour -->
<!--  -->
In this lab we will

1. Install Amazon ECS CLI
1. Deploy an ECS cluster using Fargate
1. See that CodeBuild pipelines are automatically created to scan them
1. See scan results on Sysdig Secure dashboard
