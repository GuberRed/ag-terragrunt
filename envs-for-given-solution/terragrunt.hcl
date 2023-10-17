locals{
    #customer level vars
    customer_vars = read_terragrunt_config(find_in_parent_folders("customer.hcl"))
    customer_name = local.customer_vars.locals.customer_name
    #environment level vars
    environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
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
    prefix   = "terragrunt/${local.customer_name}/${local.environment}"
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
  sa_account_id = "${local.environment}-tg-sa"
  ops_project_id = local.ops_project_id
  ops_location = local.ops_region
  bucket_name = "${local.customer_name}-${local.environment}-tg-gcs"
}