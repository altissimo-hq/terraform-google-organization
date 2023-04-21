#
# Cloud Identity Groups
#
resource "google_cloud_identity_group" "groups" {
  for_each     = var.groups
  provider     = google.sa
  display_name = coalesce(each.value.display_name, each.key)
  description  = each.value.description

  initial_group_config = "WITH_INITIAL_OWNER"

  parent = "customers/${data.google_organization.org.directory_customer_id}"

  group_key {
    id = "${each.key}@${var.domain}"
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}

resource "google_cloud_identity_group_membership" "admin" {
  provider = google.sa
  for_each = var.groups
  group    = google_cloud_identity_group.groups[each.key].id

  preferred_member_key {
    id = "${var.admin_user}@${var.domain}"
  }

  roles {
    name = "MEMBER"
  }

  roles {
    name = "OWNER"
  }
}

resource "google_cloud_identity_group_membership" "terraform" {
  provider = google.sa
  for_each = var.groups
  group    = google_cloud_identity_group.groups[each.key].id

  preferred_member_key {
    id = module.terraform.0.service_accounts["terraform"].email
  }

  roles {
    name = "MEMBER"
  }

  roles {
    name = "OWNER"
  }
}
