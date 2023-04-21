resource "google_storage_bucket" "terraform" {
  count    = var.create_terraform_project ? 1 : 0
  name     = "${var.project_prefix}-terraform"
  location = "US"
  project  = module.terraform.0.project_id
  labels   = var.labels
}
