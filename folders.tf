module "folders" {
  # source  = "../terraform-google-folders"
  source  = "altissimo-hq/folders/google"
  version = "1.0.0"

  parent = data.google_organization.org.name
  folders = {
    for folder, bindings in var.folders : folder => {
      for principal, roles in bindings : replace(principal, "DOMAIN", var.domain) => roles
    }
  }
}
