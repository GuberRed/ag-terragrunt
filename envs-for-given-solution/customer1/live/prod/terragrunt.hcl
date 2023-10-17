include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "../../coe-msp-tf-modules/sa-creation"
}