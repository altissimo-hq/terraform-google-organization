module "terraform" {
  count  = var.create_terraform_project ? 1 : 0
  source = "altissimo-hq/project/google"

  project_id      = "${var.project_prefix}-terraform"
  project_name    = var.project_name_prefix != null ? "${var.project_name_prefix} - Terraform" : "Terraform"
  billing_account = var.billing_account
  org_id          = data.google_organization.org.org_id

  iam_policy = {
    "roles/iam.serviceAccountTokenCreator" = [
      "user:${var.admin_user}@${var.domain}",
    ],
    "roles/owner" = [
      "user:${var.admin_user}@${var.domain}",
    ]
    "roles/storage.admin" = [
      "user:${var.admin_user}@${var.domain}",
    ]
  }

  labels = var.labels

  service_accounts = {
    "terraform" = {
      display_name = "Terraform Service Account"
    }
  }

  services = [
    "cloudidentity.googleapis.com",
    "secretmanager.googleapis.com",
  ]
}

module "project" {
  for_each = var.projects
  source   = "altissimo-hq/project/google"

  project_id      = "${var.project_prefix}-${each.key}"
  project_name    = each.key
  billing_account = var.billing_account
  folder_id       = each.value.parent_folder != null ? module.folders.folders[each.value.parent_folder].id : null
  org_id          = each.value.parent_folder == null ? data.google_organization.org.org_id : null

}
