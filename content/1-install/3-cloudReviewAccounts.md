---
title: "Cloud Accounts Install check"
chapter: true
weight: 3
---

## Review accounts connected

There are [different methods](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-aws/#confirm-the-services-are-working) to check that the installation was successful. 

One quick way to check it is to visit the [**Data Sources > Cloud Accounts**](https://secure.sysdig.com/#/data-sources/cloud-accounts)
dashboard to review that an account with your *Account ID* is connected.

![Cloud Account Connected](/images/1-installation/cloudaccountsconnected.png)

If this is your first install, you'll find a unique entry
(instead of multiples, like in the image above).
Check that the displayed *Account ID* matches your AWS's *Account ID*.