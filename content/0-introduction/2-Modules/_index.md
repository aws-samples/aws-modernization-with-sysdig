---
title: "Modules"
weight: 2
---

After completing the installation of Sysdig Secure for cloud,
take each of the different modules listed below. 
There are no dependencies between modules.



Module | Submodule | Use-case | Description | ETA
------------ | ------------ | ------------- | ------------- | -------------
This section | Submodule | Workshop Intro | What's this workshop about and what can you learn here? | -------------
[Prerequisites](../../0-prerequisites.html) | | Workshop setup | Prerequisites to setup the workshop. | -------------
[1. Installation](../../1-installation.html) | Terraform | Deploy Sysdig Secure for CLoud | Deploy the Sysdig Stack to secure your AWS workloads | -------------
&nbsp; | CloudFormation | Deploy Sysdig Secure for CLoud | Deploy the Sysdig Stack to secure your AWS workloads | -------------
[2. Vulnerability Management](../../2-vulnerability-management.html) | Submodule | Image Scanning | desc | -------------
&nbsp; | Submodule | Image Scanning | desc | -------------
[3. Security Posture](../../3-posture.html) | Submodule | Posture | desc | -------------
[4. Threat Detection](../../4-thread-detection.html) | Submodule | Translation | desc.translation. | -------------
&nbsp; | Submodule | Translation | desc.translation. | -------------
&nbsp; | Submodule | Translation | desc.translation. | -------------
[Cleanup](../9-cleanup.html) | Submodule | Cleanup workshop resources | How to remove all of the workshop's resources from your account. | -------------

If you run out of time in the workshop, don't panic! 
These instructions are public and they are available after your workshop ends.


<!--TODO: remove all the technical information under this section and include into the relevant sections on each module as:

- intro / technical background
- final dig deeper section
-->


curl -s "http://localhost:8080/ui/" | grep -q "Falcosidekick UI" \
|| fail-message "Falcosidekick-ui is not working properly"