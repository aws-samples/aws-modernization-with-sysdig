---
title: "EKS: Install the Sysdig Agents"
chapter: true
weight: 3
---

{{% notice info %}}
*Estimated module duration: 5-10 minutes.*
{{% /notice %}}


## Requirements

- Kubectl configured with access to the EKS cluster
- Helm


Before you start with the installation,
configure `kubectl` to connect to your EKS cluster with:

```
cd ~/learn-terraform-provision-eks-cluster
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```


## Install the Sysdig Agent

The next steps will deploy the Sysdig Agent in all the nodes of
the EKS deployed during the prerequisites step.

1. Click [here](https://secure.sysdig.com/#/data-sources/agents?setupModalEnv=Kubernetes)
   or, alternatively, log into Sysdig Secure, and browse to
   **Integrations > Data Sources > Sysdig Agents**,
   then **Add Agent > Kubernetes Cluster**.
   Insert a cluster name of your choice.

    ![Install with Helm](/images/1-installation/agentInstall.png)

2. Copy the content to your preferred IDE. 
   There, add a parameter to enable _KSPM_:

    ```bash
    --set kspm.deploy=true
    ```

    At the end, you should have something similar to this
    (substituted by your user data, instead of variables):

    ```bash
    kubectl create ns sysdig-agent
    helm repo add sysdig https://charts.sysdig.com
    helm repo update
    helm install sysdig-agent --namespace sysdig-agent \
        --set global.sysdig.accessKey=$SYSDIG_AGENT_KEY \
        --set global.sysdig.region=us1 \
        --set nodeAnalyzer.secure.vulnerabilityManagement.newEngineOnly=true \
        --set global.kspm.deploy=true \
        --set nodeAnalyzer.nodeAnalyzer.benchmarkRunner.deploy=false \
        --set global.clusterConfig.name=$CLUSTER_NAME \
        sysdig/sysdig-deploy
    ```

3. In your terminal, set the environmental variables with your account data:

    ```bash
    export SYSDIG_API_TOKEN=17f43073-f4k3-f4k3-9117-65ac17eaa84d
    export SYSDIG_AGENT_KEY=d5ef4566-f4k3-f4k3-92eb-0727fc0991f3
    export CLUSTER_NAME=aws-workshop
    ```

4. Then, copy the command from your IDE (step 3) and execute it in your terminal.
   The Sysdig Agents are being deployed now on each of the nodes of the cluster.


## Install the k8s Admission Controller

The Kubernetes Admission Controller (AC) will enable the 
[Kubernetes Audit Logging Capabilities of Sysdig Secure](https://docs.sysdig.com/en/docs/sysdig-secure/secure-events/kubernetes-audit-logging/#kubernetes-audit-logging).

1. First, visit the [**Runtime Policies** section](https://secure.sysdig.com/#/policies)
   and enable the *All K8s Activity* Policy. This policy will alert about each and every
   K8s Audit Event.

2. Deploy the Admission Controller to ingest **Kubernetes Audit logs** from the EKS cluster.

    ```bash
    kubectl create ns sysdig-admission-controller
    helm install sysdig-admission-controller sysdig/admission-controller \
        --create-namespace -n sysdig-admission-controller \
        --set sysdig.secureAPIToken=$SYSDIG_API_TOKEN \
        --set clusterName=$CLUSTER_NAME \
        --set sysdig.url=https://secure.sysdig.com/ \
        --set features.k8sAuditDetections=true \
        --set scanner.enabled=false
    ```


## Review installation

### Agents

Check that the _Agent_ installation was successful in the 
**Integrations > Data Sources >** [**Sysdig Agents** section](https://secure.sysdig.com/#/data-sources/agents).

### Admission Controller:

Check that the _Admission Controller_ installation was successful by
generating an event that will be registered in the k8s API:

1. Trigger the event with:
    ```bash
    kubectl exec -n sysdig-agent \
        $(kubectl -n sysdig-agent get pod -l app=sysdig-agent \
            --output=jsonpath={.items..metadata.name} \
        | cut --delimiter " " --fields 1) -- ls /bin/ > /dev/null
    ```

2. Then, visit the
   [**Events** section](https://secure.sysdig.com/#/events?groupBy=policy&last=86400&severities=high%2Cmedium%2Clow%2Cnone)
    and it will show up after you select the *Info* level.

    ![Event triggered](/images/1-installation/event.png)


3. Alternatively, check the admission-controler pod logs:

    ```bash
    kubectl logs -f -n sysdig-admission-controller -l app.kubernetes.io/component=webhook
    ```

    You should see something like this:

    ```logs
    {"level":"info","component":"webhook","time":"2022-11-16T09:33:34Z","message":"enable K8s Audit detections based on Falco rules: true"}
    {"level":"info","component":"console-notifier","time":"2022-11-16T10:54:56Z","message":"K8s Serviceaccount Created (user=system:kube-controller-manager serviceaccount=horizontal-pod-autoscaler ns=kube-system resp=200 decision=allow reason=)"}
    ...
    ```