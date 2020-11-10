---
title: "3. Sign-up for a Sysdig Trial account"
chapter: false
weight: 30
---

You need a Sysdig Secure account to complete this workshop. In particular you will need to make a note of your account's associated API token & API Endpoint to configure the integrations.

1. Sign-up for a free Sysdig trial here [https://sysdig.com/company/free-trial/](https://sysdig.com/company/free-trial/)  

    - You will receive a confirmation email with a confirmation link

2. Click the link and log into Sysdig, and make a note of the following two items (see animated GIF below for details on how to obtain these two values)

 - The '**Sysdig Secure API Endpoint**' you are routed to.  The will be the Sysdig Secure hostname in the browser URL. It should be one of the following
     - https://secure.sysdig.com
     - https://eu1.app.sysdig.com
     - https://us2.app.sysdig.com

         For more information of Sysdig's regional URLs, please refer to the [Sysdig documentation](https://docs.sysdig.com/en/saas-regions-and-ip-ranges.html).

 - Your '**Sysdig Secure API Token**'. Click your initials on the left nav bar, click '**Settings**' and navigate to '**User Profile**'.

        **IMPORTANT:** Make sure you DO NOT use the **Sysdig Monitor** API Token, or the **Access Token**!

3. Copy and run (paste with **Ctrl+P**) the following two commands to configure your __Secure API Token__ and  __Secure API Endpoint__ as environment variables.

```sh
echo "Enter your 'Sysdig Secure API Token' from above"; read SecureAPIToken 
```

```sh
echo "Enter your 'Sysdig Secure API Endpoint' from above"; read SecureEndpoint
```

<img src=/images/10_prerequisites/apiValues.gif width="100%" >
