---
title: "2. Identity and Access"
chapter: true
weight: 2
---


# Cloud Identity and Entitlements Management (CIEM)

Cloud vendors like AWS stablish a
[Shared Responsibility Model](https://aws.amazon.com/compliance/shared-responsibility-model/)
in which the cloud vendor is responsible for the security "_of_" the cloud,
whereas the customer (_you_) is responsible for the security "_in_" the cloud.
One of the key elements that cloud users have to protect too are
the **Identity and Access** configurations.

Over-permissioned identities is the most common cloud service misconfiguration security problem.
Implementing least privilege is a crucial best practice to avoid or mitigate risks 
of data breaches and contain privilege escalation and lateral movement.
Carefully giving a user exactly what they need to perform their duties is 
fundamental to avoiding an attacker escalating privileges inside the environment.

Sysdig Secure for cloud analyzes the audit logs of all executed cloud commands 
in your accounts and correlates them with policies, roles, and users. 
Sysdig also highlights risks that are not related to permissions.

And, most importantly, it provides a **remediation** workflow to suggest
and apply fixes to improve your Identity and Access Cloud posture.


{{% notice info %}}
This section provides an overview of Sysdig CIEM.
To provide accurate suggestions, Sysdig stablish a minimal baseline of time (learning mode)
that might be bigger than the lifespan of this workshop. Hence, you might
not be able to explore in this example the whole functionality.
Observe the panel in Overview section to learn what's the status of your accounts:
`Learning`, `Disconnected` or `Completed`.
{{% /notice %}}