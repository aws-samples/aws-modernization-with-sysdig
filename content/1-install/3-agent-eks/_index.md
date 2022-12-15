---
title: "EKS: Install the Sysdig Agents"
chapter: true
weight: 4
---

{{% notice info %}}
*Estimated module duration: 5-10 minutes.*
{{% /notice %}}


## Requirements

- EKS cluster (deployed in the last step [here](/0-prerequisites/3-cloud9.html))
- Kubectl configured with access to the EKS cluster
- Helm


## Install the Sysdig Agent

The next steps will deploy the Sysdig Agent in all the nodes of
the EKS deployed during the prerequisites step.

1. Log into Sysdig Secure, and browse to
   **Integrations > Data Sources > Sysdig Agents**,
   then [**Add Agent > Kubernetes Cluster**](https://secure.sysdig.com/#/data-sources/agents?setupModalEnv=Kubernetes).
   Insert a cluster name of your choice and copy the resulting command.

    ![Install with Helm](/images/1-installation/agentInstall.png)

2. The Kubernetes Admission Controller (AC) enable the 
   [Kubernetes Audit Logging Capabilities of Sysdig Secure](https://docs.sysdig.com/en/docs/sysdig-secure/secure-events/kubernetes-audit-logging/#kubernetes-audit-logging)
   among other features (for example, vulnerability management for your k8s images).
   
   Update the secureAPIToken parameter below with your **Sysdig Secure API Token** available in
   your account [**Settings**](https://us2.app.sysdig.com/secure/#/settings/user).
   Remember to add the trailing `\` at the end of the new options.

   In your IDE, add the next options to the command above:
   
   ```
   --set admissionController.enabled=true \
   --set global.sysdig.secureAPIToken=036cf4k3-f4k3-f4k3-f4k3-... \
   ```

3. Execute the resulting command in your terminal.
   The Sysdig Agents are being deployed now on each of the nodes of the cluster.

    ```bash
    kubectl create ns sysdig-agent
    helm repo add sysdig https://charts.sysdig.com
    helm repo update
    helm install sysdig-agent --namespace sysdig-agent \
        --set global.sysdig.accessKey=9345f4k3-f4k3-f4k3-f4k3-f4k308c706d0  \
        --set global.sysdig.region=us2 \
        --set nodeAnalyzer.secure.vulnerabilityManagement.newEngineOnly=true \
        --set global.kspm.deploy=true \
        --set nodeAnalyzer.nodeAnalyzer.benchmarkRunner.deploy=false \
        --set global.clusterConfig.name=your_cluster_name \
        --set admissionController.enabled=true \
        --set global.sysdig.secureAPIToken=036cf4k3-f4k3-f4k3-f4k3-f4k36321de0a \
        sysdig/sysdig-deploy
    ```

4. Finally, visit the [**Runtime Policies** section](https://secure.sysdig.com/#/policies)
   and enable the *Sysdig K8s Activity Logs* and *Sysdig K8s Notable Events* policies.
   This policy will alert about each and every K8s Audit Event.


## Review installation

### Agents

Check that the _Agent_ installation was successful in the 
**Integrations > Data Sources >** [**Sysdig Agents** section](https://secure.sysdig.com/#/data-sources/agents).

### Admission Controller:

Check that the _Admission Controller_ installation was successful by
generating an event that will be registered in the k8s API:

1. Trigger some events with:
    ```bash
    kubectl exec -n sysdig-agent \
        $(kubectl -n sysdig-agent get pod -l app=sysdig-agent \
            --output=jsonpath={.items..metadata.name} \
        | cut --delimiter " " --fields 1) -- ls /bin/ > /dev/null

    kubectl run nginx --image nginx --privileged
    ```

2. Then, visit the
   [**Events** section](https://secure.sysdig.com/#/events?groupBy=policy&last=86400&severities=high%2Cmedium%2Clow%2Cnone)
    and it will show up after you select the *Info* level.

    ![Event triggered](/images/1-installation/event.png)


3. Alternatively, check the admission-controller pod logs:

    ```bash
    kubectl logs -f -n sysdig-agent \
        -l app.kubernetes.io/component=webhook \
        --tail=-1 --follow=false
    ```

    You should see something like this:

    ```logs
    ...
    {"level":"info","component":"console-notifier","time":"2022-12-15T15:20:11Z","message":"Pod started with privileged container (user=kubernetes-admin pod=222nginx111 ns=default images=nginx)"}
    ...
    ```