resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = var.ops_location
  project       = var.ops_project_id
  force_destroy = true   

  versioning {
    enabled = false
  }
}