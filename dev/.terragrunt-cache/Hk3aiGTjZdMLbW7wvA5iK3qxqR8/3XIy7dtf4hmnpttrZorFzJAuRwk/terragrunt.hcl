locals{
    environment_vars = read_terragrunt_config("env.hcl")
    ops_project_id  = local.environment_vars.locals.ops_project_id
}
include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "../../coe-msp-tf-modules/sa-creation"
}

inputs = {
  sa_account_id = "testyaaaasda" #var.sa_account_id
  ops_project_id = local.ops_project_id#"gcp-coe-msp-sandbox" #var.ops_project_id
}