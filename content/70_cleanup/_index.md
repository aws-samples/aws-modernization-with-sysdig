---
title: "Cleanup"
chapter: true
weight: 70
---

## Cleanup
#### Module 3
1. Delete the log group created to test the Falco rule modification

    ```
    aws logs delete-log-group --log-group-name "test_unused_region" --region="us-west-2"
    ```

1. Delete an S3 bucket

    ```
    aws s3api delete-bucket --bucket $BUCKETNAME
    ```

#### Module 2
1. Remove `ecsTaskExecutionRole`

    ```
    aws iam detach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy --region us-east-1

    aws iam --region us-east-1 delete-role --role-name ecsTaskExecutionRole
    ```

1. Remove ECS Cluster

    ```
    stack=tutorial
    services="$(aws ecs list-services --cluster "$stack" | grep "$stack" | sed -e 's/"//g' -e 's/,//')"
    for service in $services; do
        aws ecs update-service --cluster "$stack" --service "$service" --desired-count 0
        aws ecs delete-service --cluster "$stack" --service "$service"
    done

    for id in $(aws ecs list-container-instances --cluster "$stack" | grep container-instance | sed -e 's/"//g' -e 's/,//'); do
        aws ecs deregister-container-instance --cluster "$stack" --container-instance "$id" --force
    done

    for service in $services; do
        aws ecs wait services-inactive --cluster "$stack" --services "$service"
    done

    aws ecs delete-cluster --cluster "$stack"
    aws cloudformation delete-stack --stack-name "$stack"
    ```

1. Delete log group created with `ecs-cli compose`

    ```
    aws logs delete-log-group --log-group-name tutorial
    ```

1. Remove Image Scanner Integration for Fargate

    ```
    aws cloudformation delete-stack --stack-name ECSImageScanning

    aws cloudformation delete-stack --stack-name amazon-ecs-cli-setup-tutorial
    ```

#### Module 1
1. Remove container image from Amazon ECR Registry
    ```
    docker system prune --all
    ```

1. Remove Docker Node.JS Dockerfile & Source

    ```
    rm -rf /home/ec2-user/environment/hello-world-node-vulnerable
    rm -rf /home/ec2-user/environment/hello-world-node-vulnerable.zip
    ```

    <!-- **TrainingNote** Check This works. ECRImageScanning stack still in account -->
    <!-- https://sysdigworkshop.s3.amazonaws.com/cloud-connector-unique-bucket.yaml -->

1. Remove Amazon ECR Registry

    ```
    aws ecr delete-repository --repository-name aws-workshop --force
    ```

1. Remove Amazon ECR Integration

    ```
    aws cloudformation delete-stack --stack-name ECSImageScanning
    ```


#### Introduction
1. Remove S3 Buckets

    ```
    CCBUCKET=$(aws s3 ls|grep 'cloud-connector' | awk '{print $3}')
    aws s3 rm s3://$CCBUCKET --recursive
    aws s3api delete-bucket --bucket $CCBUCKET

    CFBUCKET=$(aws s3 ls|grep 'cf-templates' | awk '{print $3}')
    aws s3 rm s3://$CFBUCKET --recursive
    aws s3api delete-bucket --bucket $CFBUCKET
    ```
1. Remove CloudConnector ECS Cluster

    ```
    aws ecs delete-cluster --cluster CloudConnector
    ```

1. Installing the CloudConnector CloudFormation Template

    ```
    aws cloudformation delete-stack --stack-name CloudConnector
    ```

1. Disable Security Hub

    ```
    aws securityhub disable-security-hub
    ```

1. Delete `Sysdig-Workshop-Admin` IAM role

     ```
     aws iam detach-role-policy --role-name Sysdig-Workshop-Admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

     aws iam delete-role --role-name Sysdig-Workshop-Admin
     ```


1. Remove Cloud9 Workstation

       ```
       aws cloud9 delete-environment --environment-id $(aws cloud9 list-environments | jq '.environmentIds[]' | xargs)
       ```

{{% notice warning %}}
This action stops the Cloud9 Workspace you are currently working on.
{{% /notice %}}
