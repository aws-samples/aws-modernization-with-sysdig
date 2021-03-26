---
title: "Cleanup"
chapter: false
weight: 34
---

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
