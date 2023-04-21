output "org" {
  description = "Google Organization Resource"
  value       = data.google_organization.org
}

output "terraform_project" {
  description = "Terraform Project Module"
  value       = var.create_terraform_project ? module.terraform.0 : null
}
