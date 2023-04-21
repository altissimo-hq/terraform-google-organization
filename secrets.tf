resource "google_secret_manager_secret" "terraform-sa-key" {
  count     = var.create_terraform_project ? 1 : 0
  project   = module.terraform.0.project_id
  secret_id = "terraform-sa-key"

  replication {
    automatic = true
  }

  labels = var.labels
}

resource "google_service_account_key" "terraform" {
  count              = var.create_terraform_project ? 1 : 0
  service_account_id = module.terraform.0.service_accounts["terraform"].id
}

resource "google_secret_manager_secret_version" "terraform-sa-key" {
  count       = var.create_terraform_project ? 1 : 0
  secret      = google_secret_manager_secret.terraform-sa-key.0.id
  secret_data = base64decode(google_service_account_key.terraform.0.private_key)
}
