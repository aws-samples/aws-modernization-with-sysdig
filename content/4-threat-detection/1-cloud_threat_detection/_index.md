---
title: "CloudTrail"
chapter: true
weight: 1
---

In this section we will explain how to audit AWS CloudTrail events with Sysdig. Once Sysdig **Secure for cloud** is deployed in your infrastructure, every CloudTrail entry is analysed in real time, and evaluated against a flexible set of security rules based on Falco.


This allows you to detect unexpected or unwanted activity quickly and raise notifications or automate reactions when something, or someone, creates, deletes or modifies your cloud resources, hence protecting you from compromised cloud accounts or involuntary human error.

A rich set of Falco rules are included and curated by Sysdig Threat Research Team and the great Falco community. Most of the rules come from investigations, standards and/or benchmarks like NIST 800-53, PCI DSS, SOC 2, MITRE ATT&CK®, CIS AWS, AWS Foundational Security Best Practices.

### Rules

Sysdig rules use Falco format, and define the conditions under which an alert will be generated, what context to be captured and what the output will be.

### Policies

Sysdig Secure Runtime Policies are a combination of rules grouped by activities an enterprise wants to detect in an environment, the actions that should be taken if the policy rule is breached. In the case of Cloud Security, these may relate to activities within your AWS account, such as users being created or updated, S3 buckets being manipulated or the execution of an interactive command.

Let's start:

1. Browse to Sysdig Secure, and navigate to **'Policies > Threat Detection > Runtime Policies'**, expand the **'AWS CloudTrail'** and click the '**Sysdig AWS Threat Detection**' policy

    ![Runtime Policies](/images/40_module_2/sysdig-runtime-policies-aws-cloudtrail.png)

    You can see the list of rules that make up this policy on the right column.

2. Click and expand rule '**Share RDS Snapshot with Foreign Account**'

    ![Runtime Policies](/images/runtime_policies_03.png)

    You'll notice that this is a regular Falco rule.  

    ```YAML
    - rule: Share RDS Snapshot with Foreign Account
      description: Detect sharing an RDS snapshot with a foreign AWS account.
      condition: aws.eventName = "ModifyDBSnapshotAttribute" and not aws.errorCode 
        exists and jevt.value[/requestParameters/attributeName] = "restore" and 
        jevt.value[/requestParameters/valuesToAdd/0] != "all"
      output: An RDS snapshot has been shared with a foreign AWS account (requesting 
        user=%aws.user, requesting IP=%aws.sourceIP, AWS region=%aws.region, RDS 
        snapshot=%jevt.value[/requestParameters/dBSnapshotIdentifier], foreign 
        account=%jevt.value[/requestParameters/valuesToAdd/0])
      priority: critical
      tags:
      - cloud
      - source=cloudtrail
      - NIST800_53_AU8
      - aws
      - NIST800_53
      source: aws_cloudtrail
      tags: Cloud, SOC2, SOC2_CC8.1, AWS_WAF_SEC-8, AWS_RDS, PCI_DSS_1.3.4, PCI_DSS_1.3.6, 
        AWS_WAF, AWS, PCI, PCI_DSS, PCI_DSS_1.3.1, ISO, ISO_27001_A.13.1.1, 
        PCI_DSS_1.2.1, PCI_DSS_7.2.1, ISO_27001
    ```

    CloudTrail compatibility is achieved in Falco by handling its events as JSON objects, and referring to the event information using JSONPath. Some points to note about this rule:

     - The **jevt.value** contains the JSON content of the event, and we are using it in the **condition**. Using the [jsonpath](https://jsonpath.com/) format, we can indicate what parts of the event we want to evaluate.  In this case this Falco rule is triggered when the CloudTrail event 'eventname' is 'DeleteBucketEncryption'.

     - The **output** will provide context information including the requester **username** and **IP address** - this is what will be sent through all of the enabled notification channels.

    This rule is one of many thats included out-of-the-box in Sysdig Secure for Cloud.

3. Browse to Sysdig Secure, and navigate to **'Policies > Threat Detection > Rules > Rules Library'** to see a list of all Falco rules relating to CloudTrail

4. Select '**AWS**' from the '**Select Tags**' list at the top

    ![CloudTrail Falco Policy Rules](/images/falco_rules_01.png)

    You will see a list of rules with various tags.

5. Highlight the rule '**Share RDS Snapshot with Foreign Account**' (use the **Search** if you want) to see the actual Falco rule, and the Sysdig Policy in which it is used, in this case '**Sysdig AWS Threat Detection**'. You can click on the policy to get back to the Runtime Policy view again.

    ![CloudTrail Falco Policy Rules](/images/falco_rules_02.png)


In the next step we'll play the red team and generate a suspicious event so that a Falco rule is triggered and we can see it in action.
