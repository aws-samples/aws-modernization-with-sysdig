terraform {
    required_providers {
        sysdig = {
            source  = "sysdiglabs/sysdig"
        }
    }
}

provider "sysdig" {

    sysdig_secure_url       = "<your_sysdig_secure_region_endpoint"

    sysdig_secure_api_token = "f4k3k375-f4k3-f4k3-f4k3-f4k3k375f4k3"
}

provider "aws" {

  region = "us-east-1"
}

module "single-account" {
    
  source = "sysdiglabs/secure-for-cloud/aws//examples/single-account"
}