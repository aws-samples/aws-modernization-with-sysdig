
+++
title = "Install the Orchestrator"
chapter = true
weight = 20
+++

In this step you'll be installing the **Orchestrator Agent**. This component is a collection point installed on each ECS cluster, and has two main functions. First, it collects data from the *Sysdig Serverless Workload Agent*, and sends them to the *Sysdig backend*. Second, it syncs the Falco runtime policies and rules to Sysdig Serverless Workload Agent from the Sysdig backend.

## Requirements for this step

You will need some information from your Sysdig account:

- your *Agent Access Key*
- and your *Collector address*

To get them, go to [*Get Started*](https://secure.sysdig.com/#/onboarding) section in *Sysdig Secure* and from the *Install the Agent* tab copy them. They'd look something like this:

- *d5ef7776-92eb-d0c2-4174-0727fc0981f3*
- *collector-static.sysdigcloud.com*

## Installing the Orchestrator Agent with Terraform

1. Create a Terraform manifest with the next modules:

    ```
    cd ~/terraform

    cat << 'EOF' > ./agentone.tf
    provider "aws" {
      region = var.region
    }

    module "fargate-orchestrator-agent" {
      source  = "sysdiglabs/fargate-orchestrator-agent/aws"
      version = "0.1.1"

      vpc_id           = var.vpc_id
      subnets          = [var.subnet_a_id, var.subnet_b_id]

      access_key       = var.access_key

      collector_host   = var.collector_host
      collector_port   = var.collector_port

      name             = "sysdig-orchestrator"
      agent_image      = "quay.io/sysdig/orchestrator-agent:latest"

      # True if the VPC uses an InternetGateway, false otherwise
      assign_public_ip = true

      tags = {
        description    = "Sysdig Serverless Agent Orchestrator"
      }
    }

    EOF
    ```
    The variables used in the module have already been defined during the previous steps.

2. Then, apply the manifest. This will create the orchestrator agent (in scenarios of bigger complexity, this step needs to be replicated for each VPC).


```
terraform apply \
  -var="region=" \
  -var="vpc_id=$VPC_ID" \
  -var="subnet_a_id=SUBNET_1_ID" \
  -var="subnet_b_id=SUBNET_2_ID" \
  -var="region=" \
  -var="access_key=" \
  -var="collector_host=" \
  -var="collector_port="
  -auto-approve
```


## (LEGACY) Installing the Orchestrator Agent with CloudFormation

1. Obtain the *Sysdig orchestrator Agent yaml* (provided below).

2. Go to [*CloudFormation Create Stack form*](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/template). Or go to *CloudFormation* in your *AWS Console* and click on **Create Stack**.

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

```
AWSTemplateFormatVersion: 2010-09-09
Description: Sysdig AWS support
Metadata:
  AWS::CloudFormation::Interface:
    ParameterGroups:
    - Label:
        default: Sysdig Settings
      Parameters:
      - SysdigAccessKey
      - SysdigCollectorHost
      - SysdigCollectorPort
    - Label:
        default: Network Settings
      Parameters:
      - VPC
      - SubnetA
      - SubnetB
    - Label:
        default: Advanced Settings
      Parameters:
      - SysdigAgentTags
      - SysdigOrchestratorAgentImage
      - SysdigCheckCollectorCertificate
    ParameterLabels:
      VPC:
        default: VPC Id
      SubnetA:
        default: Subnet A
      SubnetB:
        default: Subnet B
      SysdigAccessKey:
        default: Sysdig Access Key
      SysdigCollectorHost:
        default: Sysdig Collector Host
      SysdigCollectorPort:
        default: Sysdig Collector Port
      SysdigAgentTags:
        default: Agent Tags
      SysdigOrchestratorAgentImage:
        default: Sysdig Orchestrator Agent Image
      SysdigCheckCollectorCertificate:
        default: Check Collector SSL Certificate

Parameters:
  VPC:
    Type: AWS::EC2::VPC::Id
    Description: VPC where your service is deployed
  SubnetA:
    Type: AWS::EC2::Subnet::Id
    Description: A subnet that can access internet and is reachable by instrumented services
  SubnetB:
    Type: AWS::EC2::Subnet::Id
    Description: A subnet that can access internet and is reachable by instrumented services
  SysdigAccessKey:
    Type: String
  SysdigOrchestratorAgentImage:
    Type: String
    Default: quay.io/sysdig/orchestrator-agent:latest
  SysdigCollectorHost:
    Type: String
    Default: collector.sysdigcloud.com
  SysdigCollectorPort:
    Type: String
    Default: "6443"
  SysdigAgentTags:
    Type: String
    Description: Enter a comma-separated list of tags (eg. role:webserver,location:europe).
    Default: ""
  SysdigCheckCollectorCertificate:
    Type: String
    Default: "true"

Outputs:
  OrchestratorHost:
    Description: Host to which fargate workload agents need to connect
    Value: !GetAtt SysdigLoadBalancer.DNSName
  OrchestratorPort:
    Description: The port the fargate workload agent needs to connect to
    Value: "6667"

Resources:
  SysdigAgentCluster:
    Type: AWS::ECS::Cluster
    Properties:
      Tags:
        - Key: application
          Value: sysdig

  SysdigOrchestratorAgentLogs:
    Type: AWS::Logs::LogGroup

  SysdigOrchestratorAgentExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Statement:
          - Effect: Allow
            Principal:
              Service: ecs-tasks.amazonaws.com
            Action: 'sts:AssumeRole'
      ManagedPolicyArns:
        - 'arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy'
      Tags:
        - Key: application
          Value: sysdig
  SysdigOrchestratorAgentTaskRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Statement:
          - Effect: Allow
            Principal:
              Service: ecs-tasks.amazonaws.com
            Action: 'sts:AssumeRole'
      # ManagedPolicyArns:
      #   -
      Policies:
        - PolicyName: root
          PolicyDocument:
            Version: 2012-10-17
            Statement:
                # Permissions given in the default iam role for ecs tasks
              - Effect: Allow
                Action:
                  - "ecr:GetAuthorizationToken"
                  - "ecr:BatchCheckLayerAvailability"
                  - "ecr:GetDownloadUrlForLayer"
                  - "ecr:BatchGetImage"
                  - "logs:CreateLogGroup"
                  - "logs:CreateLogStream"
                  - "logs:PutLogEvents"
                Resource: "*"
      Tags:
        - Key: application
          Value: sysdig
  SysdigOrchestratorAgentSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Allow agentino to connect
      VpcId: !Ref VPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 6667
          ToPort: 6667
          CidrIp: 0.0.0.0/0
      Tags:
        - Key: application
          Value: sysdig
  SysdigOrchestratorAgent:
    Type: AWS::ECS::TaskDefinition
    DependsOn: SysdigOrchestratorAgentLogs
    Properties:
      NetworkMode: awsvpc
      RequiresCompatibilities:
        - FARGATE
      Cpu: 2048
      Memory: 8GB
      ExecutionRoleArn: !Ref SysdigOrchestratorAgentExecutionRole
      TaskRoleArn: !Ref SysdigOrchestratorAgentTaskRole
      ContainerDefinitions:
        - Name: OrchestratorAgent
          Image: !Ref SysdigOrchestratorAgentImage
          Environment:
            - Name: ACCESS_KEY
              Value: !Ref SysdigAccessKey
            - Name: COLLECTOR
              Value: !Ref SysdigCollectorHost
            - Name: COLLECTOR_PORT
              Value: !Ref SysdigCollectorPort
            - Name: TAGS
              Value: !Ref SysdigAgentTags
            - Name: CHECK_CERTIFICATE
              Value: !Ref SysdigCheckCollectorCertificate
          PortMappings:
            - ContainerPort: 6667
          LogConfiguration:
            LogDriver: awslogs
            Options:
              awslogs-region: !Ref AWS::Region
              awslogs-group: !Ref SysdigOrchestratorAgentLogs
              awslogs-stream-prefix: ecs
      Tags:
        - Key: application
          Value: sysdig

  SysdigLoadBalancer:
    Type: AWS::ElasticLoadBalancingV2::LoadBalancer
    Properties:
      IpAddressType: ipv4
      Scheme: internal
      Type: network
      Subnets:
        - !Ref SubnetA
        - !Ref SubnetB
      Tags:
        - Key: application
          Value: sysdig

  SysdigTargetGroup:
    Type: AWS::ElasticLoadBalancingV2::TargetGroup
    Properties:
      Port: 6667
      Protocol: TCP
      TargetType: ip
      TargetGroupAttributes:
        - Key: deregistration_delay.timeout_seconds
          Value: 60 # default is 300
      VpcId: !Ref VPC

  SysdigLoadBalancerListener:
    Type: AWS::ElasticLoadBalancingV2::Listener
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref SysdigTargetGroup
          Type: forward
      LoadBalancerArn: !Ref SysdigLoadBalancer
      Port: 6667
      Protocol: TCP

  SysdigOrchestratorAgentService:
    Type: AWS::ECS::Service
    DependsOn:
      - SysdigLoadBalancerListener
    Properties:
      ServiceName: SysdigOrchestratorAgent
      Cluster: !Ref SysdigAgentCluster
      TaskDefinition: !Ref SysdigOrchestratorAgent
      DeploymentConfiguration:
        MinimumHealthyPercent: 100
        MaximumPercent: 200
      DesiredCount: 1
      LaunchType: FARGATE
      PlatformVersion: 1.4.0
      NetworkConfiguration:
        AwsvpcConfiguration:
          AssignPublicIp: ENABLED
          Subnets:
            - !Ref SubnetA
            - !Ref SubnetB
          SecurityGroups:
            - !Ref SysdigOrchestratorAgentSecurityGroup
      LoadBalancers:
        - ContainerName: OrchestratorAgent
          ContainerPort: 6667
          TargetGroupArn: !Ref SysdigTargetGroup
      Tags:
        - Key: application
          Value: sysdig
```