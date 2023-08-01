provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

module "single-account-cspm" {
  providers = {
    aws = aws.us-east-1
  }
  source           = "draios/secure-for-cloud/aws//modules/services/trust-relationship"
  role_name        = "sysdig-secure-oox3"
  trusted_identity = "arn:aws:iam::263844535661:role/us-west-2-production-secure-assume-role"
  external_id      = "1f65149fbc6a6680106f88af257ffcc0"
}

module "single-account-threat-detection-us-east-1" {
  providers = {
    aws = aws.us-east-1
  }
  source                  = "draios/secure-for-cloud/aws//modules/services/event-bridge"
  target_event_bus_arn    = "arn:aws:events:us-west-2:263844535661:event-bus/us-west-2-production-falco-1"
  trusted_identity        = "arn:aws:iam::263844535661:role/us-west-2-production-secure-assume-role"
  external_id             = "1f65149fbc6a6680106f88af257ffcc0"
  name                    = "sysdig-secure-cloudtrail-d1de"
  deploy_global_resources = true
}
