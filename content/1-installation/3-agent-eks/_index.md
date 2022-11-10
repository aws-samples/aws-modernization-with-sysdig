
+++
title = "EKS: Install the Sysdig Agents"
chapter = true
weight = 3
+++

## Install the Sysdig Agents in an EKS cluster

The next steps will deploy the Sysdig Agents in the EKS deployed during the prerequisites step.

1. Log into Sysdig Secure, and browse to **Get Started**, then **Install the Agent > Helm**.

    ![Install with Helm](/images/Get_Started.png)

    You can fill from the form the cluster name, or completely remove this option from your helm install command.
    Copy the content to your preferred IDE and add a parameter to enable KSPM:

    ```
    --set kspm.deploy=true
    ```

    At the end, you should have something similar to this:

    ```
    kubectl create ns sysdig-agent
    helm repo add sysdig https://charts.sysdig.com
    helm repo update
    helm install sysdig-agent --namespace sysdig-agent \
        --set global.sysdig.accessKey=d5ef4566-d0c2-4174-92eb-0727fc0991f3 \
        --set agent.sysdig.settings.collector=collector-static.sysdigcloud.com \
        --set agent.sysdig.settings.collector_port=6443 \
        --set global.clusterConfig.name=<CLUSTER_NAME> \
        --set nodeAnalyzer.nodeAnalyzer.apiEndpoint=secure.sysdig.com \
        --set nodeAnalyzer.secure.vulnerabilityManagement.newEngineOnly=true \
        --set kspm.deploy=true \
        sysdig/sysdig-deploy
    ```

    - **Stack Name**: You can leave this as its default 'Sysdig-CloudVision'

    - **Sysdig Secure Endpoint**: Enter the value in your Sysdig Secure domain name, i.e. one of the following

          - `https://secure.sysdig.com`

          - `https://eu1.app.sysdig.com`

          - `https://us2.app.sysdig.com`

            Remember to include `https://` at the beginning, and no trailing slash at the end.

    -  **Sysdig Secure API Token**: enter your 'Sysdig Secure API Token' for your Sysdig Secure account. You can find this in your Sysdig Secure User Profile.

          <!-- You can find this in your Sysdig Secure User Profile (**Note** Please make sure you logged into Sysdig Secure, and not Sysdig Monitor). ![API token](/images/30_module_1/sysdig_api_01.png) -->

    <!-- - **Sysdig Agent Key**: _Paste your Sysdig Secure Agent key_    -->

    - **Modules to Deploy**: For the purposes of this lab, please make sure all options are selected.


2. Make sure to check the two tick boxes at the end

    - ✅ **I acknowledge that AWS CloudFormation might create IAM resources with custom names**.

    - ✅ **I acknowledge that AWS CloudFormation might require the following capability: CAPABILITY_AUTO_EXPAND**

        The first of these is required to create the IAM roles for the new resources, and the second is to execute sub-templates that this template incorporates for the different features of Sysdig Secure for cloud.

3. Click **Create stack**

4. Wait until the installation finishes

    You will first see the stack "Sysdig-CloudVision" in "CREATE_IN_PROGRESS" state. It will also start to create 7 sub-stacks associated with the main one. When you refresh the status of the template and it shows "CREATE_COMPLETE" for all of them, the installation is finished.

    ![Create complete](/images/cloudsec-site/cloudformation/installation/installation_complete.png)
