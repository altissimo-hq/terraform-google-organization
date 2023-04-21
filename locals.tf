locals {

  # create a map of permissions that get assigned at the org level to the admin user
  admin_iam_policy_map = {
    "user:${var.admin_user}@${var.domain}" = var.admin_roles
  }

  # create a map of permissions that get assigned at the org level to the entire domain
  domain_iam_policy_map = {
    "domain:${var.domain}" = var.domain_roles
  }

  # create a map of permissions that get assigned at the org level to each group
  group_iam_policy_map = {
    for group, config in var.groups : "group:${group}@${var.domain}" => config.roles
  }

  # merge the maps and transpose
  iam_policy_bindings = transpose(merge(
    local.admin_iam_policy_map,
    local.domain_iam_policy_map,
    local.group_iam_policy_map,
  ))
}

output "iam_policy_bindings" {
  description = "IAM policy bindings for the organization."
  value       = local.iam_policy_bindings
}
