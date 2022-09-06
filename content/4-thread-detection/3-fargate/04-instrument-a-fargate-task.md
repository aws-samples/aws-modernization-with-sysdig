
+++
title = "Instrumenting a Fargate task"
chapter = true
weight = 40
+++

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

```
AWSTemplateFormatVersion: 2010-09-09
Description: An example CloudFormation template for Fargate.
Parameters:
  VPC:
    Type: AWS::EC2::VPC::Id
  SubnetA:
    Type: AWS::EC2::Subnet::Id
  SubnetB:
    Type: AWS::EC2::Subnet::Id
Resources:
  FalcoDemoCluster:
    Type: AWS::ECS::Cluster
  TaskDefinition:
    Type: AWS::ECS::TaskDefinition
    # Makes sure the log group is created before it is used.
    DependsOn: LogGroup
    Properties:
      # awsvpc is required for Fargate
      NetworkMode: awsvpc
      RequiresCompatibilities:
        - FARGATE
      # 256 (.25 vCPU) - Available memory values: 0.5GB, 1GB, 2GB
      # 512 (.5 vCPU) - Available memory values: 1GB, 2GB, 3GB, 4GB
      # 1024 (1 vCPU) - Available memory values: 2GB, 3GB, 4GB, 5GB, 6GB, 7GB, 8GB
      # 2048 (2 vCPU) - Available memory values: Between 4GB and 16GB in 1GB increments
      # 4096 (4 vCPU) - Available memory values: Between 8GB and 30GB in 1GB increments
      Cpu: 512
      # 0.5GB, 1GB, 2GB - Available cpu values: 256 (.25 vCPU)
      # 1GB, 2GB, 3GB, 4GB - Available cpu values: 512 (.5 vCPU)
      # 2GB, 3GB, 4GB, 5GB, 6GB, 7GB, 8GB - Available cpu values: 1024 (1 vCPU)
      # Between 4GB and 16GB in 1GB increments - Available cpu values: 2048 (2 vCPU)
      # Between 8GB and 30GB in 1GB increments - Available cpu values: 4096 (4 vCPU)
      Memory: 1GB
      # A role needed by ECS.
      # "The ARN of the task execution role that containers in this task can assume. All containers in this task are granted the permissions that are specified in this role."
      # "There is an optional task execution IAM role that you can specify with Fargate to allow your Fargate tasks to make API calls to Amazon ECR."
      ExecutionRoleArn: !Ref ExecutionRole
      # "The Amazon Resource Name (ARN) of an AWS Identity and Access Management (IAM) role that grants containers in the task permission to call AWS APIs on your behalf."
      TaskRoleArn: !Ref TaskRole
      ContainerDefinitions:
        - Name: InstrumentedImage
          # Ref is not handled yet :(
          Image: "sysdiglabs/writer-to-bin:latest"
          # We override EntryPoint during rewrite so we MUST be explicit in the template
          EntryPoint: []
          Command: ["/usr/bin/demo-writer-c", "/usr/bin/oh-no-i-wrote-in-bin"]
          # Send application logs to CloudWatch Logs
          LogConfiguration:
            LogDriver: awslogs
            Options:
              awslogs-region: !Ref AWS::Region
              awslogs-group: !Ref LogGroup
              awslogs-stream-prefix: ecs
  # A role needed by ECS
  ExecutionRole:
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
  # A role for the containers
  TaskRole:
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
            # Needed for creating log group for falco
          - Effect: Allow
            Action: "cloudwatch:*"
            Resource: "*"
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
  ContainerSecurityGroup:  # aka no security group
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: TEST ONLY
      VpcId: !Ref VPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 0
          ToPort: 65535
          CidrIp: 0.0.0.0/0
  Service:
    Type: AWS::ECS::Service
    Properties:
      ServiceName: SDSDemoSvc
      Cluster: !Ref FalcoDemoCluster
      TaskDefinition: !Ref TaskDefinition
      DeploymentConfiguration:
        MinimumHealthyPercent: 100
        MaximumPercent: 200
      DesiredCount: 1
      LaunchType: FARGATE
      # This is required otherwise we do not get SYS_PTRACE :(
      PlatformVersion: 1.4.0
      NetworkConfiguration:
        AwsvpcConfiguration:
          AssignPublicIp: ENABLED
          Subnets:
            - !Ref SubnetA
            - !Ref SubnetB
          SecurityGroups:
            - !Ref ContainerSecurityGroup
  LogGroup:
    Type: AWS::Logs::LogGroup
```