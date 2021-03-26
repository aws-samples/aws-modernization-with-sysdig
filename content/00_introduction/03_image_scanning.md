<!-- +++
title = "Image Scanning Overview"
chapter = false
weight = 03
+++ -->

Sysdig Secure provides a comprehensive suite of tools to enhance and compliance across your application's ecosystem.   One critical part of this is scanning the images in your registry.

Sysdig’s **ImageVision** technology identifies vulnerabilities and misconfigurations by automating scanning within CI/CD pipelines and registries, as well as implementing registry scanning inline. It also blocks vulnerabilities pre-production, monitors for new CVEs at runtime, and helps you map a critical vulnerability back to an application and dev team.

![Image Scanning](/images/00_introduction/image_scanning01.png)

An image scanner inspects a container's content to **detect threats** such as unencrypted passwords, known vulnerabilities, exposed ports, etc.  You can implement [scanning best practices](https://sysdig.com/blog/image-scanning-best-practices/) on several phases of your **DevOps pipeline**, blocking threats before they are deployed into production, and without adding extra overhead.

Sysdig Secure manages every aspect of the container scan. With Sysdig you can define **image scanning policies** to validate a container's content against **vulnerability databases**, and search for **misconfigurations** like running as a privileged user, unnecessary open ports, or leaked credentials.

Not only can you create multiple policies that determine what the scan is looking for, but also _when_ to implement it. For example, in your CI/CD pipeline you may wish to use the test site **https://sandbox.payment-engine.com/** during your automated QA tests, but when building containers for production this must be the live **https://live.payment-engine.com**.  Or, you may wish to scan specifically for PSI or NIST compliance in a production site.

Further, you may wish to scan existing running containers for **zero day** vulnerabilities that have recently been detected.

In either case, the output of the scan will be sent back to Sysdig from where you can browse the results or run reports.

Although containers may be ingested into another system in order to be scanned, for example a Sysdig Secure backend, it's considered best practice to scan the image 'inline', i.e. locally in its current location.   

With inline scanning, the contents of your containers will never leave your infrastructure. This protects your privacy and prevents credentials for repositories from leaking. It may also be a requirement when security concerns require an air-gapped environment.

![Fargate Inline Scanning](/images/00_introduction/inline_scanning.png)

Further, from an architectural standpoint, it is more scalable to have images scanned at the edge rather than sent to a central location.  
