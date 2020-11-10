---
title: "Install Amazon ECS CLI"
chapter: false
weight: 40
---

We will use the Amazon ECS CLI tool to deploy an example ECS cluster, so we'll need to install it on our Cloud9 Workspace.  To install Amazon ECS CLI, follow the steps below

1. Log into your Cloud9 Workspace

2. Download the Amazon ECS CLI binary and make it executable .

    ```
    sudo curl -sLo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
    sudo chmod +x /usr/local/bin/ecs-cli
    ```

3. Check installation

    ```
    ecs-cli --version
    ```

4. Now create a file named `task-execution-assume-role.json` for our IAM role as follows

    ```
    cat <<- 'EOF' > "task-execution-assume-role.json"
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
            "Service": "ecs-tasks.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    EOF
    ```


5.  Create task execution role and attach the task execution role policy:

    ```
    aws iam --region us-east-1 create-role --role-name ecsTaskExecutionRole --assume-role-policy-document file://task-execution-assume-role.json

    aws iam --region us-east-1 attach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
    ```
