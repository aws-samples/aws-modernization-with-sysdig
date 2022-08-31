---
title: "Initiate CodeBuild Pipelines Build and Scan"
chapter: false
weight: 33
---

<!-- **DevNotes: Should the inline scan for ECS exit 0 when the images has known vulns?**

**DevNotes: The ECS scan passed for quay.io/awsdemosec/amazon-ecs-sample in AWS CodeBuild. I didnt see it in Sysdig until I realised it was maybe already scanned in my '+kube' secure account. So I searched and found it, and it showing as failed in Sysdig** -->


Now that a sample image has been deployed, the scanner should pick this up and scan it automatically

If you wish, you can check the CodeBuild pipeline status by visiting: [Developer Tools > CodeBuild](https://console.aws.amazon.com/codesuite/codebuild/projects?region=us-east-1). Click on the 'Sysdig-CloudVision-ScanningCodeBuildStack-*' build project, then click the build to drill down and tail the logs as the scan proceeds

1. Now go to [CodeBuild > Build projects](https://console.aws.amazon.com/codesuite/codebuild/projects) and see the task progress.

    ![Build projects](/images/codebuild01.png)

1. Click on the 'Sysdig-CloudVision-ScanningCodeBuildStack-*' build project, then click the build to drill down and tail the logs as the scan proceeds

    ![Build projects](/images/40_module_2/image9.png "image_tooltip")
