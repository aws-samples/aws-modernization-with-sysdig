
+++
title = "1. Installation"
chapter = true
weight = 20
+++


# Module 1: Installation

{{% notice info %}}
*Estimated module duration: 5-10 minutes.*
{{% /notice %}}

## Available installers

There are multiple ways to provision **Sysdig Secure for cloud** in AWS:

- [Terraform-based]()
- [CloudFormation Template (CFT)-based]()

Pick one of the available methods to continue with this workshop. 
We recommend you to follow the Terraform-based method. But following one or the other depends on the user preferences and previous experience with each of the tools (Terraform or AWS CloudFormation).

## What is enabled with this installer?

Important note: this installer enable all the next Sysdig Secure Cloud features:

- asdf
- asdf
- asdf

{{% notice warning %}}
This installer do not enable Fargate Runtime Threat Detection. For this feature, it is required to follow a different [installation method](/4-thread-detection/2-runtime_security/2-fargate.html) (covered in Module 4).
{{% /notice %}}

{{% notice note %}}
If you do not have a Sysdig account, then you can follow the steps [here](/0-prerequisites/2-sysdig_account.html) to create a free trial Sysdig Account.
{{% /notice %}}