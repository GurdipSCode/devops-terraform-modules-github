# Create GitHub repositories with comprehensive settings
resource "github_repository" "repos" {
  for_each = var.repositories

  # Basic Settings
  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility

  # Repository Features
  has_issues      = each.value.has_issues
  has_projects    = each.value.has_projects
  has_wiki        = each.value.has_wiki
  has_downloads   = each.value.has_downloads
  has_discussions = each.value.has_discussions

  # Repository Settings
  is_template               = each.value.is_template
  allow_merge_commit        = each.value.allow_merge_commit
  allow_squash_merge        = each.value.allow_squash_merge
  allow_rebase_merge        = each.value.allow_rebase_merge
  allow_auto_merge          = each.value.allow_auto_merge
  delete_branch_on_merge    = each.value.delete_branch_on_merge
  squash_merge_commit_title = each.value.squash_merge_commit_title
  merge_commit_title        = each.value.merge_commit_title

  # Auto-init
  auto_init          = each.value.auto_init
  gitignore_template = each.value.gitignore_template
  license_template   = each.value.license_template

  # Security
  vulnerability_alerts = each.value.vulnerability_alerts

  # Topics
  topics = each.value.topics

  # Homepage
  homepage_url = each.value.homepage_url

  # Archive
  archived = each.value.archived

  # Lifecycle - Prevent accidental deletion
  lifecycle {
    prevent_destroy = false  # Set to true in production
    ignore_changes = [
      # Ignore these if managed outside Terraform
      # auto_init,
    ]
  }
}
