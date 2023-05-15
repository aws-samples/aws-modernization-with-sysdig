---
title: "Simulate an attack"
chapter: false
weight: 2
---



## Trigger a security event

To trigger security events in your EKS cluster, the [falco event generator](https://github.com/falcosecurity/event-generator) will be used.

1. Go back to your terminal and execute the next command:
   
    ```
    kubectl create ns event-generator
    helm upgrade --install event-generator falcosecurity/event-generator \
        --namespace event-generator \
        --create-namespace \
        --set config.command=test \
        --set config.actions=""
    ```

    The activity of this workload will generate activity in the cluster that might be an indicator of a compromised environment.
    In the next section, you will learn how to investigate the incident in Sysdig Secure.


## Reproducing more advanced attack patterns

The example above is a quick way to demonstrate how some of the default Falco rules are triggered in a real environment.

To learn more about more advanced attack scenarios, visit the [Sysdig Public training page](https://learn.sysdig.com/).