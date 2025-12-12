resource "github_organization_settings" "org" {
  billing_email                                                = "billing@example.com"
  company                                                      = "My Company"
  blog                                                         = "https://example.com"
  email                                                        = "info@example.com"
  twitter_username                                             = "mycompany"
  location                                                     = "San Francisco"
  name                                                         = "My Organization"
  description                                                  = "We build cool stuff"

  # Repository defaults
  default_repository_permission                                = "read"
  members_can_create_repositories                              = true
  members_can_create_public_repositories                       = false
  members_can_create_private_repositories                      = true
  members_can_create_internal_repositories                     = false
  members_can_create_pages                                     = true
  members_can_fork_private_repositories                        = false

  # Security
  web_commit_signoff_required                                  = true
  advanced_security_enabled_for_new_repositories               = true
  dependabot_alerts_enabled_for_new_repositories               = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = true
}