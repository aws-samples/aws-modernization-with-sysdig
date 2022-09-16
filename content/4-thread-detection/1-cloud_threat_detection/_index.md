---
title: "4.1. CloudTrail"
chapter: true
weight: 1
---

Sysdig Secure Runtime Policies are a combination of rules about activities an enterprise wants to detect in an environment, the actions that should be taken if the policy rule is breached. In the case of Cloud Security, these may relate to activities within your AWS account, such as users being created or updated, S3 buckets being manipulated or the execution of an interactive command.

1. Browse to Sysdig Secure, and navigate to 'Policies > Runtime Policies', filter by '**AWS CloudTrail**' from the 'Select policy type' dropdown and highlight the '**Sysdig AWS Threat Detection**' policy

    <!-- ![Runtime Policies](/images/runtime_policies_01.png) -->

    You can see the list of rules that make up this policy.

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

3. Browse to Sysdig Secure, and navigate to 'Policies > Rules > Rules Library' to see a list of all Falco rules relating to CloudTrail

4. Select '**aws**' from the '**Select Tags**' list

    ![CloudTrail Falco Policy Rules](/images/falco_rules_01.png)

    You will see a list of rules with various tags.

5. Highlight the rule '**Share RDS Snapshot with Foreign Account**' to see the actual Falco rule, and the Sysdig Policy in which it is used, in this case '**AWS CloudTrail security event**'

    ![CloudTrail Falco Policy Rules](/images/falco_rules_02.png)

6. You can click on **AWS CloudTrail security event** to view the Runtime Policy again.

In the next step we'll play the red team and generate a suspicious event so that a Falco rule is triggered and we can see it in action.
