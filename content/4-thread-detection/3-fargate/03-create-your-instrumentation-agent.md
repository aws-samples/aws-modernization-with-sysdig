
+++
title = "Instrumentation Agents"
chapter = true
weight = 30
+++

Once your Orchestrator Agent is deployed and you have the *Orchestrator Host* and *Port* from the output tab in the previous step, you are ready to instrument your tasks running in Fargate.

1. Go to Cloud9 and download the required tooling. You just need to execute:

```
cd ~/environment
mkdir serverless-agent
cd serverless-agent
wget https://download.sysdig.com/dependencies/serverless/fargate/installer-linux-amd64
```

*Please, note that this step can be executed from different *operative systems*. In this example we are using a *Linux* instance running in *Cloud9* (where the AWS credentials are configured for this workshop) but you can execute it too from *MacOS* or *Windows*.*

2. Once that the installer is downloaded, exectute the binary with your own data as arguments:

    - *Name* the macro, for example *agentino* (just alphanumeric characters)
    - Include your *OrchestratorHost*
    - Include your *OrchestratorPort*

    And execute it:

```
chmod +x installer-linux-amd64
./installer-linux-amd64 cfn-macro install agentino <OrchestratorHost> <OrchestratorPort>
```

You'll get the next error:

```
could not get aws bucket could not verify bucket kilt-190636387084-us-east-1 exists/create it: could not create S3 bucket kilt-190636387084-us-east-1: operation error S3: CreateBucket, https response error StatusCode: 400, RequestID: R1DWV1H5V5MJJT0M, HostID: GSs1BfVz1Q3/afgV82q1f7CMlgGE6/pB/wH6qqSqWj13lXkPlS8tf1CBObbTergN1A3BdK1QvT8=, api error InvalidLocationConstraint: The specified location-constraint is not valid
```

3. Currently this step is failing due to a known issue with S3 buckets in this region. To continue, you need to manually create the bucket using the *aws-cli*. Execute the next command substituting the bucket name (copy it from the error output):

```
aws s3api create-bucket --bucket <bucket_name> --region us-east-1
```

And you'll get a confirmation that the bucket has been created:

```
$ aws s3api create-bucket --bucket kilt-190636387084-us-east-1 --region us-east-1
{
    "Location": "/kilt-190636387084-us-east-1"
}
```

Then, execute again the previous command (click the up-arrow until you find it). Now, you'll get something like this:

```
$ ./installer-linux-amd64 cfn-macro install agentino zarit-Sysdi-HTDIRDAI2QZ1-91890089da1b6db4.elb.us-east-1.amazonaws.com 6667
Kilt detected the following:
 * account id: 190636387084
 * region: us-east-1
kilt bucket name: kilt-190636387084-us-east-1
Installing macro pauagent...
Uploading lambda code. This might take a while...DONE
Uploading kilt definition cfn-macro-pauagent.kilt.cfg...DONE
Submitted cloudformation stack 'KiltMacropauagent'. Follow creation progress in AWS console
After installation is completed you will be able to use "Transform: ["agentino"]" in your template to automatically instrument it
```

**You are done with the configuration!** The macro has been created with *Kilt*, an open-source library for *Fargate* container injection.

Copy the: `Transform: \<macro-name>` from the output and save it. You will include it in all the task templates you want to instrument.

In the next step, you'll deploy a new task in Fargate and learn how easy it is to instrument it.