---
title: "Deploy Sysdig Secure Automatic Image Scanner for Fargate"
chapter: false
weight: 41
---

To deploy the Sysdig image scanner for Fargate, we'll again use Amazon CloudFormation.  The procedure is identical to how we installed Amazon ECR Integration in the previous lab, so this time we'll use the AWS CLI instead.

***Note*** You can find instructions on using the CLI on the [[Sysdig Fargate scanning installation page](https://sysdiglabs.github.io/ecs-image-scanning/install.html)](https://sysdiglabs.github.io/ecs-image-scanning/install.html)


1. First, make sure your Sysdig `SecureAPIToken` and `SecureEndpoint` environment variables are set.

    ```
    echo $SecureAPIToken
    echo $SecureEndpoint
    ```

    You should have set these environment variables when setting up your [Cloud9 Workspace]({{< ref "/10_prerequisites/15_workspace_setup/23_cloud.md" >}}).

    **IMPORTANT** If these variable are not set, then you can set them manually using the information you noted from [here]({{< ref "/10_prerequisites/30_sysdig.md" >}}).

1. Let's set our CloudFormation template URL as an environment variable to simplify the actual `aws` command.  

    ```
    CFURI="https://cf-templates-secure-scanning-ecs.s3.amazonaws.com/ecs-image-scanning.template"
    ```

2. Then run the the following AWS CloudFormation command (which uses those environment parameters)

    ```
    aws cloudformation create-stack \
    --stack-name ECSImageScanning \
    --template-body $CFURI \
    --parameters ParameterKey=ECSInlineSecureAPIToken,ParameterValue=$SecureAPIToken  ParameterKey=ECSInlineSecureEndpoint,ParameterValue=$SecureEndpoint ParameterKey=ECSInlineScanningType,ParameterValue=Inline \
    --capabilities "CAPABILITY_NAMED_IAM"
    ```

You can check the status of the CloudFormation task by browsing to the [CloudFormation UI](https://console.aws.amazon.com/cloudformation/)

![CloudFormation](/images/40_module_2/image3.png)

Wait until the CloudFormation task completes, which may take several minutes.

Once all stacks are created, you will be ready to deploy our ECS tasks in a Fargate cluster securely, as all images will be scanned automatically.  In the next steps we will see this scanning as it happens.
