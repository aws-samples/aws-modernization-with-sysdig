---
title: "View AWS Foundations Benchmark Security Posture"
chapter: false
weight: 41
---

In this exercise we will check the security posture of our AWS cloud infrastructure and remediate a potential issue.

The initial scan will occur as soon as the integration is deployed with the CF template, and daily after that by default.

1. Log into Sysdig Secure, and Browse to 'Compliance' in the left menu, then click on 'AWS Foundation Benchmarks'  

    <!-- ![AWS Foundation Benchmark](/images/aws-benchmarks01.png) -->

    <!-- ![AWS Foundation Benchmark](/images/cloudsec-site/cloud_bench/cloud_bench.png) -->

    ![AWS Foundation Benchmark](/images/cloud_benchmark_01.png)


    You will notice along the top that this benchmark is using "CIS Amazon Web Services Foundations ComplianceBenchmark"

    ![AWS Foundation Benchmark](/images/aws-benchmarks03.png)

    You'll also see a brief synopsis of how compliant your system is against this benchmark, as well as a link to download the results as a CSV file.


1. Highlight **1.9 Ensure IAM password policy prevents password reuse** under 'Identity and Access Management'

    You will notice that this resource is flagged as having failed. The reason this has failed is no password policy has been set in the account.

1. To verify no password policy has been set, go to your Cloud9 workstation and run the following command

    ```
    aws iam get-account-password-policy
    ```

    You will likely see an error such as This

    ```
    An error occurred (NoSuchEntity) when calling the GetAccountPasswordPolicy operation: The Password Policy with domain name 128440595215 cannot be found.
    ```

1. Expand the **Remediation Procedure**.  You'll see a number of manual remediation steps. Execute the command line fix

    ```
    aws iam update-account-password-policy --password-reuse-prevention 24
    ```  

1.  You can verify the change by rerunning the former command

    ```
    aws iam get-account-password-policy
    ```

    This should return content similar to the following

    ```
    {
      "PasswordPolicy": {
          "MinimumPasswordLength": 6,
          "RequireSymbols": false,
          "RequireNumbers": false,
          "RequireUppercaseCharacters": false,
          "RequireLowercaseCharacters": false,
          "AllowUsersToChangePassword": false,
          "ExpirePasswords": false,
          "PasswordReusePrevention": 24
      }
    }
    ```

1.  The next time the scan occurs this control will now pass, and appear as follows

    ![AWS Foundation Benchmark](/images/aws-benchmarks05.png)

{{% notice note %}}
The scan runs every 24 hours.
{{% /notice %}}
