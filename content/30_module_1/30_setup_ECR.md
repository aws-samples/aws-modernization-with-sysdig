---
title: "Setup Amazon ECR Registry"
chapter: false
weight: 30
---

For the purposes of this lab you need to create an Amazon ECR registry. To do this, follow the steps below

1. Log into your Cloud9 Workspace

2. Run the following command to create a repository. The name is arbitrary, but for continuity in the lab please use `aws-workshop`

  ```
  aws ecr create-repository --repository-name aws-workshop  --image-scanning-configuration scanOnPush=true
  ```

    The output will be as follows

  ```
  {
      "repository": {
          "repositoryArn": "arn:aws:ecr:us-east-1:845151661675:repository/aws-workshop",
          "registryId": "845151661675",
          "repositoryName": "aws-workshop",
          "repositoryUri": "845151661675.dkr.ecr.us-east-1.amazonaws.com/aws-workshop",
          "createdAt": 1602848100.0,
          "imageTagMutability": "MUTABLE",
          "imageScanningConfiguration": {
              "scanOnPush": true
          },
          "encryptionConfiguration": {
              "encryptionType": "AES256"
          }
      }
  }
  ```

3. You can view the repository in [Amazon UI](https://console.aws.amazon.com/ecr/repositories?region=us-east-1)


![ECR](/images/30_module_1/Amazon_ECR01.png)

### Authenticate AWS CLI With Amazon ECR registry

Shortly you will use your Cloud9 Workspace to create and push a docker container to your new ECR Repository, however, before doing so you must configure docker's access to the repository.

1. Log into your Cloud9 workspace

2. Authenticate the Docker command line tool to this Amazon ECR registry, using AWS CLI tool as follows

```bash
export ECR_NAME=aws-workshop
export REGION=us-east-1
export AWS_ACCOUNT=$(aws sts get-caller-identity | jq '.Account' | xargs)
echo "$ECR_NAME, $REGION, $AWS_ACCOUNT"
aws ecr get-login-password --region $REGION | \
  docker login --username AWS --password-stdin \
  $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com
```

      The output should look similar to the following

      ```bash
      WARNING! Your password will be stored unencrypted in /home/ec2-user/.docker/config.json.
      Configure a credential helper to remove this warning. See
      https://docs.docker.com/engine/reference/commandline/login/#credentials-store

      Login Succeeded
      ```


**Note** For more details on this procedure, please refer to [[Amazon ECR registries - Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html)](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html)
