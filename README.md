# Secure DevOps with AWS & Sysdig

In this workshop, you will learn how to securely run cloud applications in production by automating AWS Fargate and ECR image scanning directly in your AWS environment. You will also discover how to improve the security of your cloud infrastructure using AWS CloudTrail and Sysdig CloudConnector.

## Building the Website

This page is built with Hugo, so you'll need it [installed](https://gohugo.io/getting-started/quick-start/#step-1-install-hugo)

First, clone this repo:

```bash
git clone git@github.com:aws-samples/aws-modernization-with-sysdig.git
```
Ensure you've also cloned the submodules:

```bash
git submodule init
git submodule update
```

Then serve the website with hugo:

```bash
hugo server

```


### Learning Objectives
- Amazon ECR image scanning
- Amazon Fargate automated image scanning
- Amazon CloudTrail runtime security

