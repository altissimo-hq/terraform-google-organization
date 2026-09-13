provider "google" {
  alias = "sa"

  impersonate_service_account = var.create_terraform_project ? module.terraform.0.service_accounts["terraform"].email : null
}
