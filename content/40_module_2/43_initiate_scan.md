---
title: "Initiate CodeBuild Pipelines Build and Scan"
chapter: false
weight: 43
---

Now that a sample image has been deployed, the scanner should pick this up and scan it automatically

1. Now go to [CodeBuild > Build projects](https://console.aws.amazon.com/codesuite/codebuild/projects) and see the task progress.

    ![Build projects](/images/40_module_2/ecs_scan00.png)

2. Click on 'Failed' next to **ECSInlineSecureScanning** to drill down on it.

    ![Build projects](/images/40_module_2/ecs_scan04.png)

3. Click 'Failed' link and scroll down to see the scan details

    ![Build projects](/images/40_module_2/image9.png "image_tooltip")

<!--
![CodeBuild Pipelines](/images/40_module_2/image4.png "image_tooltip")

![CodeBuild Pipelines](/images/40_module_2/image10.png "image_tooltip")

![CodeBuild Pipelines](/images/40_module_2/image11.png "image_tooltip")

![CodeBuild Pipelines](/images/40_module_2/image12.png "image_tooltip")

![CodeBuild Pipelines](/images/40_module_2/image8.png "image_tooltip") -->
