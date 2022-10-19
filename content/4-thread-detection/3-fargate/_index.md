+++
title = "4.3. Fargate Runtime Thread Detection"
chapter = true
weight = 3
+++


# Fargate Runtime Thread Detection

Every modern cloud platform provides serverless platforms to run
containerized workloads without the hassle of host or infrastructure management.
AWS Fargate is one of the main alternatives out there.

Also known as "container as a service",
these platforms are flexible and cost efficient in a wide scope of use cases,
but where there's no access to the underlying host.
Hence, visibility might be obfuscate, and as a consequence of this,
security could also be compromised.

Sysdig and AWS partnered to provide a serverless agent to [instrument
Fargate workloads](https://sysdig.com/blog/securing-aws-fargate/). 
Imagine all of the power of your Falco rules for thread detection, but
packaged for your serverless workloads.

## Overview of this Module

1. Introduction
   1. Installation methods
   2. Components
   3. Prerequisites
2. Terraform install
   1. Manifests
   2. Instrument your workload
3. CloudFormation
   1. Install the Orchestrator Agent
   2. Instrumentator Agents
   3. Instrumenting a Fargate Tasks
4. Detect runtime Threads in Fargate with Sysdig Secure


## Installation methods

The serverless agents can be automatically deployed with Terraform or CloudFormation.
These are the supported methods, but Terraform is the recommended one.
For more specific use cases, your workloads can also be
[instrumented manually](https://docs.sysdig.com/en/docs/installation/serverless-agents/aws-fargate-serverless-agents/#manually-instrument-a-task-definition).

This workshop module covers how to deploy it following both methods.


## Components

The Sysdig Runtime Detection solution for AWS has two main components:

- Orchestrator Agent
- Workload Agent

The **Orchestrator Agent**. This component is a collection point installed on each ECS cluster, and has two main functions. First, it collects data from the *Sysdig Serverless Workload Agent*, and sends them to the *Sysdig backend*. Second, it syncs the Falco runtime policies and rules to Sysdig Serverless Workload Agent from the Sysdig backend.

The **workload agents** is appended to every Fargate task that is instrumented. It sends the data to the Orchestrator.


## Prerequisites

During this module, you will deploy and review the required assets to complete this demo:
- *AWS VPC* and *subnetworks*. 
- *Sysdig Secure* account (follow the instructions below to get a new account if needed)


### Networking: VPC and subnets

A sample Terraform manifest is provided for every alternative installation method (Terraform and CloudFormation) to deploy a basic network required to simulate a standard Fargate workload environment. Here, the instrumented task and the Sysdig Serverless agent will be run.


### Sysdig Secure account

Sysdig Secure provides security for containers, Kubernetes, and cloud services. A trial account is more than enough to test all you can do with Sysdig Secure and AWS Fargate. Follow the next steps if you did not completed the free trial registration for Sysdig Secure in the Prerequisites section.

1. **Register** for a [trial account](https://sysdig.com/company/free-trial-secure/). No credit card or payments are required.

2. Complete the required fields and click **Submit**.

3. Open your mail inbox and login using the provided link.

4. Done!