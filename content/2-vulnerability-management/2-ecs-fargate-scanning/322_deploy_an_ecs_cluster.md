---
title: "Deploy an ECS cluster using Fargate"
chapter: false
weight: 32
---

To illustrate automated scanning, we will now deploy a sample ECS cluster that scales using Fargate.  For the purposes of the lab this will consist of this sample PHP application running in a Docker Compose environment - https://hub.docker.com/r/amazon/amazon-ecs-sample.

1. Create a cluster configuration and create a cluster

    ```
    ecs-cli configure --cluster tutorial --default-launch-type FARGATE --config-name tutorial --region us-east-1

    ecs-cli up --cluster-config tutorial --ecs-profile tutorial-profile
    ```

    The output should show a VPC and two Subnets have been created:-

    ```
    INFO[0000] Created cluster                    cluster=tutorial region=us-east-1
    INFO[0000] Waiting for your cluster resources to be created...
    INFO[0000] Cloudformation stack status       stackStatus=CREATE_IN_PROGRESS
    INFO[0060] Cloudformation stack status       stackStatus=CREATE_IN_PROGRESS
    VPC created: vpc-046ed77edcd796e19
    Subnet created: subnet-045df8f58a51b2291
    Subnet created: subnet-0e4623283c4907ea7
    Cluster creation succeeded.
    ```

3. We will use a bash script to create our ECS cluster.  So first lets instantiate the script by copying and pasting the following commands

    ```
    cd /home/ec2-user/environment

    curl -s https://gist.githubusercontent.com/johnfitzpatrick/d55097212d9bb4e1442383a5e3339b01/raw/98953d9472edf4e023e00e28e28353687f9e726e/deploy-amazon-ecs-sample.sh > deploy-amazon-ecs-sample.sh

    chmod +x deploy-amazon-ecs-sample.sh
    ```

3. Now run the script `deploy-amazon-ecs-sample.sh`, copying and pasting the VPC & Subnet values from the above out when prompted

    ```bash
    ./deploy-amazon-ecs-sample.sh
    ```

    **Note** You can subsequently get the VPC and Subnet details requested from the 'Resources' tab on [CloudFormation UI](https://console.aws.amazon.com/cloudformation/home)

    ![ECS Cluster](/images/40_module_2/image7.png)


    The `deploy-amazon-ecs-sample.sh` script will

    - Retrieve the id of the default security group for the VPC created, and allows inbound access on port 80

    - Create a `ecs-params.yml` file using the subnets and security group already retrieved. This file should look as follows

        ```
        version: 1
        task_definition:
            task_execution_role: ecsTaskExecutionRole
            ecs_network_mode: awsvpc
            task_size:
              mem_limit: 0.5GB
              cpu_limit: 256
        run_params:
            network_configuration:
              awsvpc_configuration:
                subnets:
                  - "subnet-045df8f58a51b2291"
                  - "subnet-0e4623283c4907ea7"
                security_groups:
                  - "sg-3a1f94b6"
                assign_public_ip: ENABLED
        ```

    - Create a `docker-compose.yaml` to instantiate the image `quay.io/awsdemosec/amazon-ecs-sample`.  This file looks as follows

        ```
        version: '3'
        services:
            web:
              image: quay.io/awsdemosec/amazon-ecs-sample
              ports:
                - "80:80"
              logging:
                driver: awslogs
                options:
                  awslogs-group: tutorial
                  awslogs-region: us-east-1
                  awslogs-stream-prefix: web
        ```

        Optionally, for details of this script you can run the following command

        ```bash
        cat ./deploy-amazon-ecs-sample.sh
        ```    

6. Once the script has completed you can see details of of the ECS cluster on the [Amazon ECS UI](https://console.aws.amazon.com/ecs/home?region=us-east-1#/clusters/tutorial/services)

![Cluster Tutorial](/images/40_module_2/image5.png)

## Optional/Troubleshooting

1. You can check of the ECS state by running `ecs-cli ps`

    ```
    Name                                           State    Ports                     TaskDefinition  Health
    tutorial/7c81f4d640b84a58a1b4ddf4dbaa0bb5/web  RUNNING  3.221.149.218:80->80/tcp  tutorial:1      UNKNOWN
    ```

1. Check the deployed images with `ecs-cli images`

    ```
    REPOSITORY NAME     TAG                 IMAGE DIGEST                                                              PUSHED AT           SIZE                
    aws-workshop        latest              sha256:b9901958776c9c9881c1f7ba0e4c57f9715909eb7d78387a9481a4300585aab3   12 minutes ago      239MB               
    ```

1. Browse to the sample application using the details in `ecs-cli ps` output (e.g. 3.221.149.218:80)


    ![Sample PHP App](/images/simple_php_app.png)


### Obtain VPC & Subnet Info

You can execute the following to obtain the VPC & Subnet information

```
STACKNAME=amazon-ecs-cli-setup-tutorial
for resource in Vpc PubSubnetAz1 PubSubnetAz2
do
  aws cloudformation describe-stack-resources --stack-name $STACKNAME --query 'StackResources[?LogicalResourceId=='"'$resource'"'].PhysicalResourceId' --output text
done
```
