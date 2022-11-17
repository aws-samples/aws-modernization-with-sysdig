---
title: "4.3. Fargate Runtime Thread Detection"
chapter: true
weight: 3
---


# Fargate Runtime Thread Detection

Every modern cloud platform provides serverless platforms to run
containerized workloads without the hassle of host or infrastructure management.
AWS Fargate is one of the main alternatives out there.

Also known as "container as a service",
these platforms are flexible and cost efficient in a wide scope of use cases.
Serverless computing abstracts the infrastructure maintenance overhead
so your team can focus on your application.
But where there's no access to the underlying host,
and hence this might lead to lack of visibility and hence threats being unspotted.

Visibility might be obfuscate, and as a consequence of this,
security could also be compromised.

Sysdig Serverless agents eliminates security blind spots.
With this feature, your team will be able to detect suspicious activity
on your serverless workloads.
This thread detection engine is based on open source Falco,
so the same set of rules used for hosts, containers and Kubernetes will
be applied to your Fargate workloads.

Sysdig and AWS partnered to provide a serverless agent to [instrument
Fargate workloads](https://sysdig.com/blog/securing-aws-fargate/). 
Imagine all of the power of your Falco rules for thread detection, but
packaged for your serverless workloads.


## Installation methods

The serverless agents can be automatically deployed with:
- [Terraform](/4-thread-detection/3-fargate/1-terraform/01-terraform-install.html).
- [CloudFormation](/4-thread-detection/3-fargate/2-cloudformation.html).
  
For more specific use cases, your workloads can also be
[instrumented manually](https://docs.sysdig.com/en/docs/installation/serverless-agents/aws-fargate-serverless-agents/#manually-instrument-a-task-definition).


## Components

The Sysdig Runtime Detection solution for AWS has two main components:

- **Orchestrator Agent**. This component is a collection point installed on each ECS cluster, and has two main functions. First, it collects data from the *Sysdig Serverless Workload Agent*, and sends them to the *Sysdig backend*. Second, it syncs the Falco runtime policies and rules to Sysdig Serverless Workload Agent from the Sysdig backend.

- **Workload agents**. They are appended to every Fargate task that is instrumented. It sends the data to the Orchestrator.