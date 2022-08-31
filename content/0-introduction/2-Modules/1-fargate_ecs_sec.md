---
title: "AWS Fargate and ECS Security"
draft: false
weight: 05
---

[**Amazon Elastic Container Service**](https://aws.amazon.com/ecs) (Amazon ECS) is a fully managed container orchestration service based on Kubernetes, allowing developers to run applications without the need to configure the required running environment. Amazon ECS is fully integrated with the Docker container registry [**AWS ECR**](https://aws.amazon.com/ecr).

[**AWS Fargate**](https://aws.amazon.com/fargate) is a serverless compute engine for containers that removes the need to provision and manage servers. Fargate works alongside Amazon ECS (as well as Amazon EKS) to allocate the correct amount of compute resources for your application no matter the load, hence eliminating the need to choose instance types or scale cluster capacity. You only pay for the resources required to run your containers, so there is no over-provisioning and paying for additional servers.

**AWS Fargate** and **ECS** both allow you to deploy containerized workloads quickly. Those services are so convenient that many people leave them unattended, risking exposure to vulnerabilities inside their containers that can exfiltrate secrets, compromise business data, impact performance, and increase their AWS costs.

For example, think of some **credentials** mistakenly included in an image, later deployed on Fargate. They will be exposed to anyone with access to the image (think on the repository), or to the Fargate service.

Or consider a **known vulnerability**. Imagine you deploy a Fargate task to manage your API, and that it uses an old HTTP library version that ignores the setting to limit a request size. That could be catastrophic! Say you expect requests no bigger than 1MB, but a malicious actor exploits this vulnerability to send requests as big as 80GB. This will absolutely take a toll in your AWS bill, and might cause your service to throttle.

Those are serious threats. In this workshop you will see how Sysdig helps circumvent these threats by automating the scanning of images both at rest in Amazon ECR, as well as in ECS/Fargate, for known vulnerabilities and issues.
