include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "../../../../../modules/bucket-creation"
}
dependency "sa-creation" {
  config_path = "../sa-creation"
  skip_outputs = true
}