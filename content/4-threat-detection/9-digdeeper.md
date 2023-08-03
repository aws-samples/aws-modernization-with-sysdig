---
title: "Dig deeper: Threat Detection"
weight:  99
---

The main tool for Threat Detection and Runtime Security is [Falco](falco.org).

Falco was created by Sysdig in 2016.  It was the first runtime security project to join CNCF as a sandbox-level project, and has since graduated to incubation status.

## Falco and Runtime Security

Link to our internal course in public domain.


## CloudTrail

A set of out-of-the-box Falco rules for CloudTrail is packaged with Sysdig CDR (Cloud Detection and Response) allowing you to easily generate detections and alerts on abnormal behavior changes. 
You can also complement these with your own custom rules.
The Falco rules are also mapped against **NIST 800-190** compliance standard controls. More compliance mapping for additional compliance standards like PCI or CIS will be provided in the future

### How it works?

Similar to ECS Fargate serverless, incoming CloudTrail events are forwarded to Sysdig backend, enriched and evaluated against **Falco rules**.

![Reference Architecture](/images/50_module_3/sysdig-agentless-cloud-diagram.png)

Sysdig Cloud provides several outbound integration options. Events can be pulled from outside using Sysdig REST API. In addition, Sysdig can push events either via **notification channels** or **event forwarder**.

**Forwarding options** can transmit streams of security findings to retention services like SQS or other log tools like Splunk or Elasticsearch.  This mechanism forwards streams of events of a determined type with no discrimination.

**Notification channels** send determined events selected by Falco rules to tools like Pagerduty, OpsGenie or Slack. Notifications are ment to be actionable, meaning that is worth taking an action when they happen: trigger a runbook, automate a response or at least notify a specialized team for awareness or investigation.
