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

In this module, you will learn about Security Posture and Actionable Compliance. 

You will use Sysdig Secure to get an overview of your Cloud (CSPM) and Kubernetes (KSPM) security posture and will take action to remediate a couple of detected issues. 

You will also use the *IaC Security* feature to automatically fix one posture issue with the new Sysdig Secure integration with GitHub.


## Intro to posture

Security Posture is a wide term used to describe 
what's the security status of key assets of a company: workloads, cloud resources, permissions, etc.

Most of the tools available provides a set of controls to check,
but no actions or remediations to fix the issue.
Sysdig Secure Actionable Compliance is able to detect posture issues and remediate them inmediatly.

Adding to this, Actionable Compliance includes the next set of features:

- No event-based. There's no need for a security incident to happen to fetch the data. Relevant APIs are fetched periodically to retrieve the latest data to evaluate your security posture status.
- Sysdig AC persists the resources in its backend, and fetch it at regular intervals. This means that there's no need to reevaluate the compliance status of a given resource when there are changes in a benchmark.


## Requirements

- Sysdig Secure SaaS account
- A cloud account connected to Sysdig Secure
- For KSPM, you need to deploy the agent with the option `kspm.deploy` enabled.
- For automatic remediation (open a PR with the fix automatically) IaC Security needs to be enabled.


## Terminology

The Sysdig Docs provides a [glossary of relevant terminology](https://docs.sysdig.com/en/docs/sysdig-secure/posture/compliance/actionable-compliance/#appendix) to Actionable Compliance terms that is recommended to review before continuing.


## Status of a control

- Pass
- Fail
- Accept risk: a failed control can be removed from the failed score. 

remediations: types