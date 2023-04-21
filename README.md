<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google.sa"></a> [google.sa](#provider\_google.sa) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_folders"></a> [folders](#module\_folders) | altissimo-hq/folders/google | 1.0.0 |
| <a name="module_project"></a> [project](#module\_project) | altissimo-hq/project/google | n/a |
| <a name="module_terraform"></a> [terraform](#module\_terraform) | altissimo-hq/project/google | n/a |

## Resources

| Name | Type |
|------|------|
| [google_cloud_identity_group.groups](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group) | resource |
| [google_cloud_identity_group_membership.admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership) | resource |
| [google_cloud_identity_group_membership.terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership) | resource |
| [google_organization_iam_policy.org](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_policy) | resource |
| [google_secret_manager_secret.terraform-sa-key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.terraform-sa-key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account_key.terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_storage_bucket.terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_iam_policy.org](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |
| [google_organization.org](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_roles"></a> [admin\_roles](#input\_admin\_roles) | IAM Roles to assign to the admin user in the organization (list) | `list(string)` | <pre>[<br>  "roles/owner",<br>  "roles/resourcemanager.organizationAdmin"<br>]</pre> | no |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | Admin User Name | `string` | `"admin"` | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing Account ID | `string` | n/a | yes |
| <a name="input_create_terraform_project"></a> [create\_terraform\_project](#input\_create\_terraform\_project) | Create Terraform Project | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Cloud Identity or Google Workspace Domain Name (e.g. example.com) | `string` | n/a | yes |
| <a name="input_domain_roles"></a> [domain\_roles](#input\_domain\_roles) | IAM Roles to assign to every user in the organization (list) | `list(string)` | <pre>[<br>  "roles/billing.creator",<br>  "roles/resourcemanager.projectCreator"<br>]</pre> | no |
| <a name="input_folders"></a> [folders](#input\_folders) | Top-level Folders to create and a map of groups and their roles (map) | `map(map(list(string)))` | n/a | yes |
| <a name="input_groups"></a> [groups](#input\_groups) | Cloud Identity Groups to create and their org-level IAM roles (map) | <pre>map(object({<br>    display_name = optional(string)<br>    description  = optional(string)<br>    roles        = optional(list(string))<br>  }))</pre> | <pre>{<br>  "gcp-billing-admins": {<br>    "description": "Billing administrators are responsible for setting up billing accounts and monitoring their usage",<br>    "roles": [<br>      "roles/billing.admin",<br>      "roles/billing.creator",<br>      "roles/resourcemanager.organizationViewer"<br>    ]<br>  },<br>  "gcp-developers": {<br>    "description": "Developers are responsible for designing, coding, and testing applications",<br>    "roles": []<br>  },<br>  "gcp-devops": {<br>    "description": "DevOps practitioners create or manage end-to-end pipelines that support continuous integration and delivery, monitoring, and system provisioning",<br>    "roles": [<br>      "roles/resourcemanager.folderViewer"<br>    ]<br>  },<br>  "gcp-logging-admins": {<br>    "description": "Logging administrators have access to all features of Logging",<br>    "roles": [<br>      "roles/logging.admin"<br>    ]<br>  },<br>  "gcp-logging-viewers": {<br>    "description": "Logging viewers have read-only access to a specific subset of logs ingested into Logging",<br>    "roles": []<br>  },<br>  "gcp-monitoring-admins": {<br>    "description": "Monitoring administrators have access to use and configure all features of Cloud Monitoring",<br>    "roles": [<br>      "roles/monitoring.admin"<br>    ]<br>  },<br>  "gcp-network-admins": {<br>    "description": "Network administrators are responsible for creating networks, subnets, firewall rules, and network devices such as cloud routers, Cloud VPN instances, and load balancers",<br>    "roles": [<br>      "roles/compute.networkAdmin",<br>      "roles/compute.securityAdmin",<br>      "roles/compute.xpnAdmin",<br>      "roles/resourcemanager.folderViewer"<br>    ]<br>  },<br>  "gcp-organization-admins": {<br>    "description": "Organization administrators have access to administer all resources belonging to the organization",<br>    "roles": [<br>      "roles/billing.user",<br>      "roles/cloudsupport.admin",<br>      "roles/iam.organizationRoleAdmin",<br>      "roles/orgpolicy.policyAdmin",<br>      "roles/resourcemanager.folderAdmin",<br>      "roles/resourcemanager.organizationAdmin",<br>      "roles/resourcemanager.projectCreator",<br>      "roles/securitycenter.admin"<br>    ]<br>  },<br>  "gcp-security-admins": {<br>    "description": "Security administrators are responsible for establishing and managing security policies for the entire organization, including access management and organization constraint policies",<br>    "roles": [<br>      "roles/bigquery.dataViewer",<br>      "roles/compute.viewer",<br>      "roles/container.viewer",<br>      "roles/iam.organizationRoleViewer",<br>      "roles/iam.securityReviewer",<br>      "roles/logging.configWriter",<br>      "roles/logging.privateLogViewer",<br>      "roles/orgpolicy.policyAdmin",<br>      "roles/orgpolicy.policyViewer",<br>      "roles/resourcemanager.folderIamAdmin",<br>      "roles/securitycenter.admin"<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to all resources | `map(string)` | <pre>{<br>  "created-by": "terraform-google-organization"<br>}</pre> | no |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | Project Display Name prefix (e.g. 'Company Name') | `string` | `null` | no |
| <a name="input_project_prefix"></a> [project\_prefix](#input\_project\_prefix) | Project ID prefix (e.g. 'company-name') | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input\_projects) | Projects to create (list) | <pre>map(object({<br>    parent_folder = optional(string)<br>  }))</pre> | <pre>{<br>  "logging": {<br>    "parent_folder": "Common"<br>  },<br>  "monitoring-dev": {<br>    "parent_folder": "Common"<br>  },<br>  "monitoring-nonprod": {<br>    "parent_folder": "Common"<br>  },<br>  "monitoring-prod": {<br>    "parent_folder": "Common"<br>  },<br>  "vpc-host-dev": {<br>    "parent_folder": "Common"<br>  },<br>  "vpc-host-nonprod": {<br>    "parent_folder": "Common"<br>  },<br>  "vpc-host-prod": {<br>    "parent_folder": "Common"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_bindings"></a> [iam\_policy\_bindings](#output\_iam\_policy\_bindings) | IAM policy bindings for the organization. |
| <a name="output_org"></a> [org](#output\_org) | Google Organization Resource |
| <a name="output_terraform_project"></a> [terraform\_project](#output\_terraform\_project) | Terraform Project Module |
<!-- END_TF_DOCS -->
