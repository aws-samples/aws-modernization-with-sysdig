---
title: "Checking Security Findings in Sysdig Secure"
chapter: false
weight: 3
---

Sysdig Secure give you a single pane of glass to view all activity across your infrastructure and applications.

1. Browse to Sysdig Secure UI and click on **Events** on the left.

    You should see and event relating to **Delete Bucket Encryption**

2. Click on **Delete Bucket Encryption**

    ![Sysdig Events](/images/cloudtrail_event03b.png)

    You will see information relating to this event, including

     - AWS regions
     - Bucket name
     - Source IP Address
     - User Identity
     - Account ID

    As these are standard Sysdig event, you can easily create alerts and notifications as with any other events.

TIP: You can see the events also from the **Insights > Cloud Events** Dashboard. 

    ![Cloud Events](/images/cloudtrail_event03.png)
