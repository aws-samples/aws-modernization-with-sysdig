---
title: "Push and Scan an Image from the Registry"
chapter: false
weight: 32
---

### Download Example Dockerfile and Sources

Now that our automatic scanner is in place, we can test it by pushing a Docker container, and check if it scans.

To illustrate the images scanning we will build an example Node.JS application based on the official “hello world” example described in [their website](https://nodejs.org/de/docs/guides/nodejs-docker-webapp/).

1. Go to your Cloud9 Workspace and download and uncompress example container files


	```bash
	wget https://github.com/sysdiglabs/hello-world-node-vulnerable/releases/download/v1.0/hello-world-node-vulnerable.zip

	unzip hello-world-node-vulnerable.zip

	cd hello-world-node-vulnerable/
	```


2. And build and push the image to ECR

	```bash
	export IMAGE=$AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$ECR_NAME

	docker build . -t $IMAGE

	docker push $IMAGE
	```

4. As soon as the image has been pushed to the registry, a new **Amazon CodeBuild pipeline** will be automatically created that executes an image scan using the integrated Sysdig Inline Scanner.

	If you wish, you can check the CodeBuild pipeline status by visiting: [Developer Tools > CodeBuild](https://console.aws.amazon.com/codesuite/codebuild/projects?region=us-east-1) ![Stack details](/images/30_module_1/CodeBuild-InProgress.png)

	If you wish, you can drill down to tail the logs as the scan proceeds

	![Image Scan](/images/30_module_1/codebuild-01.png)

Once complete the scan will show the status '**Failed**'. ![Build Complete](/images/30_module_1/CodeBuild-ScanComplete-Fail.png)

**Important** This may mean the image has failed the scan, **and not** that the image scan process itself has failed. Check the CodeBuild pipeline logs to verify.

#### Optional: Further Information

You can see a complete log of the scan process by clicking [ECS Scan log](https://gist.githubusercontent.com/johnfitzpatrick/369c1f9df765be68ba2d83cbe37f6eb3/raw/421fe8d829ad74cd406d09ca6625283e4020751b/gistfile1.txt).  This shows

<!-- https://gist.github.com/johnfitzpatrick/369c1f9df765be68ba2d83cbe37f6eb3 -->

1. layers of the image getting pulled and flattened (lines 24-199)

2. analysis phase, the metadata getting sent to (lines 201-204)

3. metadata getting posted to Sysdig Backend (line 206)

	- backend analyses the metadata between lines 206 & 207

4. results of the scan are returned from the Sysdig Backend (lines 207-1979)

5. inline scanner script returns exit code 1 (line 1985)


### See Scan Results on Sysdig Secure Dashboard

To see the scan results on Sysdig Secure Dashboard,

1. Log into the Sysdig Secure UI, and browse to 'Image Scanning > Scan Results'.

![Sysdig Secure](/images/30_module_1/Sysdig_Secure02.png)

2. Click your new `aws-workshop` image.

	You'll see the image have several major vulnerabilities.

![Sysdig Secure](/images/30_module_1/securescann02.png)

With Sysdig Secure you have full visibility of the security and compliance posture across your entire estate, in a single pane of glass, and as a central location for all security profiles and policies.
