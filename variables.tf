variable "admin_roles" {
  description = "IAM Roles to assign to the admin user in the organization (list)"
  type        = list(string)
  default = [
    "roles/owner",
    "roles/resourcemanager.organizationAdmin",
  ]
}

variable "admin_user" {
  description = "Admin User Name"
  type        = string
  default     = "admin"
}

variable "billing_account" {
  description = "Billing Account ID"
  type        = string
}

variable "create_terraform_project" {
  description = "Create Terraform Project"
  type        = bool
  default     = false
}

variable "domain" {
  description = "Cloud Identity or Google Workspace Domain Name (e.g. example.com)"
  type        = string
}

variable "domain_roles" {
  description = "IAM Roles to assign to every user in the organization (list)"
  type        = list(string)
  default = [
    "roles/billing.creator",
    "roles/resourcemanager.projectCreator",
  ]
}

variable "folders" {
  description = "Top-level Folders to create and a map of groups and their roles (map)"
  type        = map(map(list(string)))
}

variable "groups" {
  description = "Cloud Identity Groups to create and their org-level IAM roles (map)"
  type = map(object({
    display_name = optional(string)
    description  = optional(string)
    roles        = optional(list(string))
  }))
  default = {
    gcp-organization-admins = {
      description = "Organization administrators have access to administer all resources belonging to the organization"
      roles = [
        "roles/billing.user",
        "roles/cloudsupport.admin",
        "roles/iam.organizationRoleAdmin",
        "roles/orgpolicy.policyAdmin",
        "roles/resourcemanager.folderAdmin",
        "roles/resourcemanager.organizationAdmin",
        "roles/resourcemanager.projectCreator",
        "roles/securitycenter.admin",
      ]
    }
    gcp-billing-admins = {
      description = "Billing administrators are responsible for setting up billing accounts and monitoring their usage"
      roles = [
        "roles/billing.admin",
        "roles/billing.creator",
        "roles/resourcemanager.organizationViewer",
      ]
    }
    gcp-network-admins = {
      description = "Network administrators are responsible for creating networks, subnets, firewall rules, and network devices such as cloud routers, Cloud VPN instances, and load balancers"
      roles = [
        "roles/compute.networkAdmin",
        "roles/compute.securityAdmin",
        "roles/compute.xpnAdmin",
        "roles/resourcemanager.folderViewer",
      ]
    }
    gcp-logging-admins = {
      description = "Logging administrators have access to all features of Logging"
      roles = [
        "roles/logging.admin",
      ]
    }
    gcp-logging-viewers = {
      description = "Logging viewers have read-only access to a specific subset of logs ingested into Logging"
      roles       = []
    }
    gcp-monitoring-admins = {
      description = "Monitoring administrators have access to use and configure all features of Cloud Monitoring"
      roles = [
        "roles/monitoring.admin",
      ]
    }
    gcp-security-admins = {
      description = "Security administrators are responsible for establishing and managing security policies for the entire organization, including access management and organization constraint policies"
      roles = [
        "roles/bigquery.dataViewer",
        "roles/compute.viewer",
        "roles/container.viewer",
        "roles/iam.organizationRoleViewer",
        "roles/iam.securityReviewer",
        "roles/logging.configWriter",
        "roles/logging.privateLogViewer",
        "roles/orgpolicy.policyAdmin",
        "roles/orgpolicy.policyViewer",
        "roles/resourcemanager.folderIamAdmin",
        "roles/securitycenter.admin",
      ]
    }
    gcp-developers = {
      description = "Developers are responsible for designing, coding, and testing applications"
      roles       = []
    }
    gcp-devops = {
      description = "DevOps practitioners create or manage end-to-end pipelines that support continuous integration and delivery, monitoring, and system provisioning"
      roles = [
        "roles/resourcemanager.folderViewer",
      ]
    }
  }
}

variable "labels" {
  description = "Labels to apply to all resources"
  type        = map(string)
  default = {
    created-by = "terraform-google-organization"
  }
}

variable "project_prefix" {
  description = "Project ID prefix (e.g. 'company-name')"
  type        = string
}

variable "project_name_prefix" {
  description = "Project Display Name prefix (e.g. 'Company Name')"
  type        = string
  default     = null
}

variable "projects" {
  description = "Projects to create (list)"
  type = map(object({
    parent_folder = optional(string)
  }))
  default = {
    vpc-host-prod = {
      parent_folder = "Common",
    }
    vpc-host-nonprod = {
      parent_folder = "Common",
    }
    vpc-host-dev = {
      parent_folder = "Common",
    }
    logging = {
      parent_folder = "Common",
    }
    monitoring-prod = {
      parent_folder = "Common",
    }
    monitoring-nonprod = {
      parent_folder = "Common",
    }
    monitoring-dev = {
      parent_folder = "Common",
    }
  }
}
