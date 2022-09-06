
+++
title = "Detect Threads in Secure"
chapter = true
weight = 50
+++

This application is writting under `/bin`, what is not a good practice. Luckily, by default you have a *Falco Rule* that detects this behaviour and a *Sysdig Policy* using this rule. So, you should get a notification out of the box.

1. Browse to [Sysdig Secure > Events](https://secure.sysdig.com/#/events/?last=600)

    Here you can find a feed with all the events that have ocurred during the last time period in your connected hosts. In this case, from your Fargate instance.

    ![Reference Architecture](/images/55_module_5/event.gif)

2. Select the triggered event and review in the lateral view all the information available.

    From here you can visualize:
    = The policy and rule that was triggered by the event
    - The Fargate instance identifier
    - AWS Region
    - Container name
    - and much more!

    ![Event Detail](/images/55_module_5/event2.png)

---

You have finished this practice. Now you are ready to **Detect Runtime security threads in your AWS Fargate workloads with Sysdig Secure**.
