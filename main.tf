#------------------------------------------------------------------------------
# GitHub Repository
#------------------------------------------------------------------------------
resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues      = var.has_issues
  has_wiki        = var.has_wiki
  has_projects    = var.has_projects
  has_downloads   = var.has_downloads
  has_discussions = var.has_discussions

  is_template    = var.is_template
  homepage_url   = var.homepage_url
  topics         = var.topics
  archived       = var.archived
  archive_on_destroy = var.archive_on_destroy

  delete_branch_on_merge = var.delete_branch_on_merge
  allow_merge_commit     = var.allow_merge_commit
  allow_squash_merge     = var.allow_squash_merge
  allow_rebase_merge     = var.allow_rebase_merge
  allow_auto_merge       = var.allow_auto_merge

  auto_init          = var.auto_init
  gitignore_template = var.gitignore_template
  license_template   = var.license_template

  vulnerability_alerts = var.vulnerability_alerts

  dynamic "template" {
    for_each = var.template_repository != null ? [var.template_repository] : []
    content {
      owner      = template.value.owner
      repository = template.value.repository
    }
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [
      auto_init,
      gitignore_template,
      license_template,
    ]
  }
}

#------------------------------------------------------------------------------
# Default Branch
#------------------------------------------------------------------------------
resource "github_branch_default" "this" {
  count = var.default_branch != null ? 1 : 0

  repository = github_repository.this.name
  branch     = var.default_branch

  depends_on = [github_branch_protection.this]
}

#------------------------------------------------------------------------------
# Branch Protection
#------------------------------------------------------------------------------
resource "github_branch_protection" "this" {
  for_each = var.branch_protections

  repository_id = github_repository.this.node_id
  pattern       = each.key

  enforce_admins         = each.value.enforce_admins
  allows_deletions       = each.value.allows_deletions
  allows_force_pushes    = each.value.allows_force_pushes
  require_signed_commits = each.value.require_signed_commits
  required_linear_history = each.value.required_linear_history

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks != null ? [each.value.required_status_checks] : []
    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews != null ? [each.value.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      restrict_dismissals             = required_pull_request_reviews.value.restrict_dismissals
      dismissal_restrictions          = required_pull_request_reviews.value.dismissal_restrictions
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
      require_last_push_approval      = required_pull_request_reviews.value.require_last_push_approval
    }
  }
}

#------------------------------------------------------------------------------
# Team Access
#------------------------------------------------------------------------------
resource "github_team_repository" "this" {
  for_each = var.team_permissions

  team_id    = each.key
  repository = github_repository.this.name
  permission = each.value
}

#------------------------------------------------------------------------------
# Collaborators
#------------------------------------------------------------------------------
resource "github_repository_collaborator" "this" {
  for_each = var.collaborators

  repository = github_repository.this.name
  username   = each.key
  permission = each.value
}

#------------------------------------------------------------------------------
# Deploy Keys
#------------------------------------------------------------------------------
resource "github_repository_deploy_key" "this" {
  for_each = var.deploy_keys

  repository = github_repository.this.name
  title      = each.key
  key        = each.value.key
  read_only  = each.value.read_only
}

#------------------------------------------------------------------------------
# Repository Webhooks
#------------------------------------------------------------------------------
resource "github_repository_webhook" "this" {
  for_each = var.webhooks

  repository = github_repository.this.name
  active     = each.value.active

  configuration {
    url          = each.value.url
    content_type = each.value.content_type
    insecure_ssl = each.value.insecure_ssl
    secret       = each.value.secret
  }

  events = each.value.events
}

#------------------------------------------------------------------------------
# Repository Files (e.g., CODEOWNERS)
#------------------------------------------------------------------------------
resource "github_repository_file" "this" {
  for_each = var.files

  repository          = github_repository.this.name
  branch              = each.value.branch
  file                = each.key
  content             = each.value.content
  commit_message      = each.value.commit_message
  commit_author       = each.value.commit_author
  commit_email        = each.value.commit_email
  overwrite_on_create = each.value.overwrite_on_create

  lifecycle {
    ignore_changes = [
      commit_author,
      commit_email,
    ]
  }

  depends_on = [github_repository.this]
}

#------------------------------------------------------------------------------
# Actions Secrets
#------------------------------------------------------------------------------
resource "github_actions_secret" "this" {
  for_each = var.actions_secrets

  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}

#------------------------------------------------------------------------------
# Actions Variables
#------------------------------------------------------------------------------
resource "github_actions_variable" "this" {
  for_each = var.actions_variables

  repository    = github_repository.this.name
  variable_name = each.key
  value         = each.value
}

#------------------------------------------------------------------------------
# Environments
#------------------------------------------------------------------------------
resource "github_repository_environment" "this" {
  for_each = var.environments

  repository  = github_repository.this.name
  environment = each.key

  dynamic "reviewers" {
    for_each = each.value.reviewers != null ? [each.value.reviewers] : []
    content {
      teams = reviewers.value.teams
      users = reviewers.value.users
    }
  }

  dynamic "deployment_branch_policy" {
    for_each = each.value.deployment_branch_policy != null ? [each.value.deployment_branch_policy] : []
    content {
      protected_branches     = deployment_branch_policy.value.protected_branches
      custom_branch_policies = deployment_branch_policy.value.custom_branch_policies
    }
  }
}
