+++
title = "4.3. Fargate Runtime Thread Detection"
chapter = true
weight = 3
+++


# Fargate Runtime Thread Detection



https://docs.sysdig.com/en/docs/installation/serverless-agents/


## Components

The Sysdig Runtime Detection solution for AWS has two main components:

- Orchestrator Agent, and its yaml configuration file ([see below]({{< ref "#sysdig-orchestrator-agent-yaml" >}}))
- Workload Agent

In this step you'll be installing the **Orchestrator Agent**. This component is a collection point installed on each ECS cluster, and has two main functions. First, it collects data from the *Sysdig Serverless Workload Agent*, and sends them to the *Sysdig backend*. Second, it syncs the Falco runtime policies and rules to Sysdig Serverless Workload Agent from the Sysdig backend.


## Overview of this Module

1. Introduction
2. Prerequisites
3. Install the Orchestrator Agent
4. Instrumentator Agents
5. Instrumenting a Fargate Tasks
6. Detect runtime Threads in Fargate with Sysdig Secure
