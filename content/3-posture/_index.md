+++
title = "3. Posture"
chapter = true
weight = 40
+++

<!-- 
SOURCES:
- docs: https://docs.sysdig.com/en/docs/sysdig-secure/posture/compliance/actionable-compliance/
- Edu Minguez blogpost:

TODOs:
- general structure
  - intro
  - files/steps
- test the demo
- fill the gaps
- peer-review
- move to instruqt
- about OPA?


DEADLINE: 14th september

DEMO:
- use andrew.d api call to refresh
- edu.minguez blogpost structure!


 -->

## About this module

In this module, you will learn about Security Posture, Compliance and remediation for compliance issues. 

You will use Sysdig Secure to get an overview of your cloud and Kubernetes security posture and will take action to remediate a couple of detected issues. 

You will also use the *IaC Security* feature to automatically fix one posture issue with the new Sysdig Secure integration with GitHub.


## Intro to posture

What is security posture? Definition.

How is it different to other solutions?

Sysdig Secure Posture & Compliance is able to detect posture issues and remediate them inmediatly.


- No event-based. There's no need for a security incident to happen to fetch the data. Relevant APIs are fetched periodically to retrieve the latest data to evaluate your security posture status.
- Sysdig AC persists the resources in its backend, and fetch it at regular intervals.


## Requirements

- For KSPM, you need to deploy the agent with the option `kspm.deploy` enabled.
- For automatic remediation (the habilit to open a PR with the fix automatically) IaC Security needs to be enabled.


## Terminology

The Sysdig Docs provides a [glossary of relevant terminology](https://docs.sysdig.com/en/docs/sysdig-secure/posture/compliance/actionable-compliance/#appendix) to the compliance topic. Here you can find an overview of the main concepts
Control:

## Status of a control

- Pass
- Fail
- Accept risk: a failed control can be removed from the failed score. 

remediations: types