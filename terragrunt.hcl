locals{
    environment_vars = read_terragrunt_config("env.hcl")
    environment  = local.environment_vars.locals.environment
    ops_project_id  = local.environment_vars.locals.ops_project_id
    ops_region  = local.environment_vars.locals.ops_region
}
remote_state {
  backend = "gcs"
  config = {
    project  = "gcp-coe-msp-sandbox"
    location = "europe-west1"
    bucket   = "terragrunt-test-cms"
    prefix   = "terragrunt/${local.environment}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.0.0"
    }
  }
}
provider "google" {
  project     = "${local.ops_project_id}"
  region      = "${local.ops_region}"
  default_labels = {
    environment = "${local.environment}"
  }
}
EOF
}
inputs = {
  sa_account_id = "${local.environment}testyaaaasda"
  ops_project_id = local.ops_project_id
}