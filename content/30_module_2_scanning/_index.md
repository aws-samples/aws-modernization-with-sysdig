+++
title = "2. Automated Image Vulnerability Scanning"
chapter = true
weight = 30
+++

# Module 2: Vulnerability Scanning

Sysdig Secure provides a comprehensive suite of tools to enhance and compliance across your application's ecosystem.   One critical part of this is scanning the images in your registry.

Sysdig’s **ImageVision** technology identifies vulnerabilities and misconfigurations by automating scanning within CI/CD pipelines and registries, as well as implementing registry scanning inline. It also blocks vulnerabilities pre-production, monitors for new CVEs at runtime, and helps you map a critical vulnerability back to an application and dev team.

![Image Scanning](/images/00_introduction/image_scanning01.png)

An image scanner inspects a container's content to **detect threats** such as unencrypted passwords, known vulnerabilities, exposed ports, etc.  You can implement [scanning best practices](https://sysdig.com/blog/image-scanning-best-practices/) on several phases of your **DevOps pipeline**, blocking threats before they are deployed into production, and without adding extra overhead.

Sysdig Secure manages every aspect of the container scan. With Sysdig you can define **image scanning policies** to validate a container's content against **vulnerability databases**, and search for **misconfigurations** like running as a privileged user, unnecessary open ports, or leaked credentials.

Not only can you create multiple policies that determine what the scan is looking for, but also _when_ to implement it. For example, in your CI/CD pipeline you may wish to use the test site **https://sandbox.payment-engine.com/** during your automated QA tests, but when building containers for production this must be the live **https://live.payment-engine.com**.  Or, you may wish to scan specifically for PSI or NIST compliance in a production site.

Further, you may wish to scan existing running containers for **zero day** vulnerabilities that have recently been detected.

In either case, the output of the scan will be sent back to Sysdig from where you can browse the results or run reports.

Sysdig Secure supports scanning of images at multiple points along the development lifecycle. In relation to services running on AWS, there are two approaches to automated image vulnerability scanning

 - ECR Automated Image Scanning
 - Fargate & ECS Automated Image Scanning  

We will look at these two scenarios separately, however, in either case, the contents of your containers will never leave your infrastructure. This protects your privacy and prevents credentials for repositories from leaking. It may also be a requirement when security concerns require an air-gapped environment.

For details of the ECR and Fargate & ECS Automated Image Scanning Reference Architecture, please refer to [Sysdig Secure for cloud documentation](https://cloudsec.sysdig.com/aws/).

<!--
## Reference Architectures

### ECR Automated Image Scanning

With ECR Automated Image Scanning, all images that are pushed to the registry will be automatically scanned within your AWS account. How this is implemented is illustrated below.

![Reference Architecture](/images/30_module_1/arch.png)

Once a new image is pushed to Amazon ECR, this is picked up by Amazon EventBridge and passed to a Lambda function which creates an ephemeral CodeBuild task to build and scan the base image.  The results of the scan are then sent to the Sysdig Secure backend.  You are not required to configure, or expose, the registry on the Sysdig Secure side. Also, the image itself is not sent to Sysdig, but only the image metadata.

An important point to note is that, although the scan actually happens with this AWS pipeline, you maintain the scanning policies and view results within Sysdig.

### Fargate & ECS Automated Image Scanning

Amazon Fargate is a serverless compute engine for containers that works with both Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes Service (EKS). It allocates the correct amount of compute resources, eliminating the need to choose instance types and scaling cluster capacity. With Fargate, you pay for the minimum resources required to run your containers.  Sysdig provides the ability to scan running Fargate services for known issues, in a similar manner to how it scans Amazon ECR.

Any **deploy command** directed at ECS Fargate will trigger an **image scanning** event. In particular the deploy command is detected by Amazon EventBridge, which will trigger a CodeBuild pipeline via an AWS Lambda function. It is within this CodeBuild pipeline that the image scanning runs. This is very similar workflow to how we seen earlier with Amazon ECR scanning.

![Reference Architecture](/images/40_module_2/image2.png "image_tooltip")

The Sysdig inline image scanner will inspect the image to be deployed and will send its metadata to the Sysdig backend. The actual image contents won't leave the CodeBuild pipeline.

![alt_text](/images/40_module_2/image13.png "image_tooltip")

The Sysdig backend then **evaluates** the container metadata against your security policies. It will generate a **scan report** if the image doesn't pass your security requirements, so you can **take action**.
 -->









<!-- Although containers may be ingested into another system in order to be scanned, for example a Sysdig Secure backend, it's considered best practice to scan the image 'inline', i.e. locally in its current location.    -->

<!-- With inline scanning, the contents of your containers will never leave your infrastructure. This protects your privacy and prevents credentials for repositories from leaking. It may also be a requirement when security concerns require an air-gapped environment. -->

<!-- ![Fargate Inline Scanning](/images/00_introduction/inline_scanning.png) -->

<!-- Further, from an architectural standpoint, it is more scalable to have images scanned at the edge rather than sent to a central location.   -->
