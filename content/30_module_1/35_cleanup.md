---
title: "Cleanup"
chapter: false
weight: 35
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