---
title: "Instrumenting a Fargate task"
chapter: true
weight: 40
---

Now you are going to deploy a new instrumented task in Fargate. To do so, you are going to create a new *CloudFormation Template (CFT)*.

Review the *CFT* provided at the bottom of this page before you deploy it. It uses the *sysdiglabs/writer-to-bin* image. This app just *writes under bin*. Once this workload is instrumented and deployed, this simple action will be detected by the agent *Runtime Detection engine* and will trigger an event in *Sysdig Secure*.

*The policy detecting this event (*Suspicious Filesystem Changes*) is enabled by default. Explore other security policies and rules and learn how can you modify them to fit your security needs. After this little practice, it might be a good idea to take one of your applications deployed in Fargate and instrument it following this steps. Then, go to Sysdig Secure and observe which policies and rulescan be applied to your particular use-case.*


## Deploying and instrumenting a CFT

1. First, instrument your template. To do so, copy the output of the previous step (`Transform: <macro-name>`) at root level of the template like the following example (**remember that you can use the CF Template provided at the bottom of this page!**):

```
  AWSTemplateFormatVersion: 2010-09-09
  Description: An example CloudFormation template for Fargate.
  Transform: agentino
  Parameters:
      VPC:
          Type: AWS::EC2::VPC::Id
```

2. Go to [*Create Stack CloudFormation form*](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/template). Or go to CloudFormation and click on *Create Stack*.

3. Select *Create template in Designer* and click *Create template in designer*. From here, switch to the Template tab (bottom of the page) and copy your template (remember to instrument it as instructed).

    ![Instrumented Task](/images/55_module_5/instrumented.png)

4. Click on *Create Stack* (cloud icon). You will need to:

    ![Create Stack](/images/55_module_5/createstack.png)

    - Click on **Next** to the **Specify stack details**
    - Name the task (for example, *falcodemocluster*)
    - Select the VPC and subnets you created in the first step.
    - Click **Next** two times until you get to the **Review** step.
    - Select the required boxes to continue.
    - Click on **Create stack**.

    In a couple of minutes the task will be deployed.


## Example CFT

Copy this template to create a new task in AWS Fargate. Remember to instrument it as explained above.

{{% code-to-md "/static/code/fargate/cloudformation/task_template.yaml" "yaml" %}}
