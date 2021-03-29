---
title: "Enable Runtime Policies"
chapter: false
weight: 23
---

### Enable Runtime Policies

A new Runtime Policy called "Sysdig AWS Best Practices" will appear in your Sysdig account once you install the Sysdig Secure for cloud CloudFormation Template.  Only rules that are part of this Runtime Policy can be triggered by audit events.

However, this is disabled by default so must be manually enabled.

1. In the Sysdig Secure UI, navigate to "Policies" and then "Runtime Policies"

1. Locate "Sysdig AWS Best Practices" policy and click on the switch to the left to enable it

    ![Enable Runtime Policy](/images/enable-policy.png)

Once the CF Template has successfully deployed, and this Runtime Policy has been enabled, you can continue with the workshop.
