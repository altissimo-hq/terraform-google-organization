resource "google_organization_iam_policy" "org" {
  org_id      = data.google_organization.org.org_id
  policy_data = data.google_iam_policy.org.policy_data
}

data "google_iam_policy" "org" {

  audit_config {
    service = "allServices"

    audit_log_configs {
      log_type = "ADMIN_READ"
    }

    audit_log_configs {
      log_type = "DATA_READ"
    }

    audit_log_configs {
      log_type = "DATA_WRITE"
    }
  }

  dynamic "binding" {
    for_each = local.iam_policy_bindings
    content {
      role    = binding.key
      members = binding.value
    }
  }

}
