resource "google_service_account" "service_account" {
  account_id   = var.sa_account_id
  project = var.ops_project_id
}