resource "github_organization_settings" "org" {
  # Organization Information
  billing_email    = var.org_billing_email
  company          = var.org_company
  blog             = var.org_blog
  email            = var.org_email
  twitter_username = var.org_twitter_username
  location         = var.org_location
  name             = var.org_name
  description      = var.org_description

  # Repository Defaults
  default_repository_permission               = var.default_repository_permission
  members_can_create_repositories             = var.members_can_create_repositories
  members_can_create_public_repositories      = var.members_can_create_public_repositories
  members_can_create_private_repositories     = var.members_can_create_private_repositories
  members_can_create_internal_repositories    = var.members_can_create_internal_repositories
  members_can_create_pages                    = var.members_can_create_pages
  members_can_fork_private_repositories       = var.members_can_fork_private_repositories

  # Security
  web_commit_signoff_required                                  = var.web_commit_signoff_required
  advanced_security_enabled_for_new_repositories               = var.advanced_security_enabled_for_new_repositories
  dependabot_alerts_enabled_for_new_repositories               = var.dependabot_alerts_enabled_for_new_repositories
  dependabot_security_updates_enabled_for_new_repositories     = var.dependabot_security_updates_enabled_for_new_repositories
  dependency_graph_enabled_for_new_repositories                = var.dependency_graph_enabled_for_new_repositories
  secret_scanning_enabled_for_new_repositories                 = var.secret_scanning_enabled_for_new_repositories
  secret_scanning_push_protection_enabled_for_new_repositories = var.secret_scanning_push_protection_enabled_for_new_repositories
}
