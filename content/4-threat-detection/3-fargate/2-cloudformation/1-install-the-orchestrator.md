---
title: "Install the Orchestrator"
chapter: false
weight: 20
---

In this step you'll be installing the **Orchestrator Agent** with CloudFormation.

This component is a collection point installed on each ECS cluster, 
and has two main functions. First, it collects data from the *Sysdig Serverless Workload Agent*, 
and sends them to the *Sysdig backend*. 
Second, it syncs the Falco runtime policies and rules to Sysdig Serverless Workload Agent 
from the Sysdig backend.


For this step, you will need some information from your Sysdig account.
Visit the [*Get Started*](https://secure.sysdig.com/#/onboarding) section in *Sysdig Secure*
and from the *Install the Agent* tab copy them.:

- your *Agent Access Key*: Something like: *d5ef7776-92eb-d0c2-4174-0727fc0981f3*.
- and your *Collector address*. Something like: *collector-static.sysdigcloud.com*.

---

And now, follow the next steps:

1. A *Sysdig orchestrator Agent CloudFormation* blueprint is provided in the assets file below 
   and in the course assets that you downloaded for this module.

2. Go to [*CloudFormation Create Stack form*](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/template). Or go to *CloudFormation* in your *AWS Console* and click on **Create Stack**.

3. Select **Create template in Designer** and click **Create template in designer**. From here, switch to the **Template** tab (bottom of the Dashboard) and copy the [orchestrator agent template]({{< ref "#sysdig-orchestrator-agent-yaml" >}}) replacing all the existing content.

4. Click on **Create Stack** (cloud icon with an up arrow inside). Then, you will need to:

    ![Create Stack](/images/55_module_5/createstack.png)

    - Click on **Next** to the **Specify stack details**
    - Set a *Name* (for example, `<my_identifier>-agentone`)
    - Set *Access Key* and *Collector* with the value retrieved from your Sysdig account
    - Select the *VPC* and *subnets* where your tasks are running or will be running.

      {{% notice warning %}}
  It is important to use the **VPC and subnets** that you created for this module. Please, do not use the existing ones for the previous EKS Module. They are identified by: *\<your_identifier\>-fargate-{vpc|subnet}*
  {{% /notice %}}

    - Click **Next** until you get to the **Review step**
    - Scroll down to the bottom
    - Check the required boxes to continue.
    - And click on **Create Stack**.

    This action takes less than *10 minutes* to be completed. Do not close this tab yet. Once that the stack creation is completed, go to **Output** and copy this two values:

    - *OrchestratorHost*
    - *OrchestratorPort*

    This data will be required in the next step. While this is being prepared, you can preview a usage example of the tool:

    {{< youtube p_M5m4DnOhQ >}}

    Example of the values in *Output* tab:

    ![Agentone](/images/55_module_5/agentone.png)


## Sysdig orchestrator Agent yaml

Just copy and paste this definition into the *CloudFormation Template designer* as explained above.

{{% code-to-md "/static/code/fargate/cloudformation/orchestrator.yaml" "yaml" %}}
