---
title: "CloudTrail Runtime Policies and Falco Rules"
chapter: false
weight: 51
---

Sysdig Secure Runtime Policies are a combination of rules about activities an enterprise wants to detect in an environment, the actions that should be taken if the policy rule is breached. In the case of Cloud Security, these may relate to activities within your AWS account, such as users being created or updated, or S3 buckets being manipulated.

1. Browse to Sysdig Secure, and navigate to 'Policies > Runtime Policies', and highlight '**AWS CloudTrail security event**'

    <!-- ![Runtime Policies](/images/runtime_policies_01.png) -->

    You can see the list of rules that make up this policy.

1. Click and expand rule '**Delete bucket encryption**'

    ![Runtime Policies](/images/runtime_policies_03.png)

    You'll notice that this is a regular Falco rule.  

    ```YAML
    - rule: Delete bucket encryption (Copy)
      desc: Detect deleting configuration to use encryption for bucket storage
      condition: >-
        jevt.value[/eventName]="DeleteBucketEncryption" and not
        jevt.value[/errorCode] exists
      output: >-
        A encryption configuration for a bucket has been deleted (requesting
        user=%jevt.value[/userIdentity/arn], requesting
        IP=%jevt.value[/sourceIPAddress], AWS region=%jevt.value[/awsRegion],
        bucket=%jevt.value[/requestParameters/bucketName])
      priority: critical
      tags:
      - cloud
      - source=cloudtrail
      - NIST800_53_AU8
      - aws
      - NIST800_53
      source: k8s_audit
      append: false
      exceptions: []
    ```

    CloudTrail compatibility is achieved in Falco by handling its events as JSON objects, and referring to the event information using JSONPath.  Some points to note about this rule:

     - The **jevt.value** contains the JSON content of the event, and we are using it in the **condition**. Using the [jsonpath](https://jsonpath.com/) format, we can indicate what parts of the event we want to evaluate.  In this case this Falco rule is triggered when the CloudTrail event 'eventname' is 'DeleteBucketEncryption'.

     - The **output** will provide context information including the requester **username** and **IP address** - this is what will be sent through all of the enabled notification channels.

    This rule is one of many thats included out-of-the-box in Sysdig CloudConnector.

1. Browse to Sysdig Secure, and navigate to 'Policies > Rules Library' to see a list of all Falco rules relating to CloudTrail

1. Select '**aws**' from the '**Select Tags**' list

    ![CloudTrail Falco Policy Rules](/images/falco_rules_01.png)

    You will see a list of rules with various tags.

1. Highlight the rule '**Delete bucket encryption**' to see the actual Falco rule, and the Sysdig Policy in which it is used, in this case '**AWS CloudTrail security event**'

    ![CloudTrail Falco Policy Rules](/images/falco_rules_02.png)

1. You can click on **AWS CloudTrail security event** to view the Runtime Policy again.

In the next step we'll go ahead and trigger this rule.
