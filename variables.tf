#------------------------------------------------------------------------------
# Required Variables
#------------------------------------------------------------------------------
variable "name" {
  description = "The name of the repository"
  type        = string
}

#------------------------------------------------------------------------------
# Repository Settings
#------------------------------------------------------------------------------
variable "description" {
  description = "A description of the repository"
  type        = string
  default     = ""
}

variable "visibility" {
  description = "Repository visibility: public, private, or internal"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["public", "private", "internal"], var.visibility)
    error_message = "Visibility must be one of: public, private, internal."
  }
}

variable "homepage_url" {
  description = "URL of a page describing the project"
  type        = string
  default     = null
}

variable "topics" {
  description = "List of topics for the repository"
  type        = list(string)
  default     = []
}

variable "archived" {
  description = "Whether the repository is archived"
  type        = bool
  default     = false
}

variable "archive_on_destroy" {
  description = "Archive the repository instead of deleting on destroy"
  type        = bool
  default     = true
}

variable "is_template" {
  description = "Whether this is a template repository"
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Repository Features
#------------------------------------------------------------------------------
variable "has_issues" {
  description = "Enable GitHub Issues"
  type        = bool
  default     = true
}

variable "has_wiki" {
  description = "Enable GitHub Wiki"
  type        = bool
  default     = false
}

variable "has_projects" {
  description = "Enable GitHub Projects"
  type        = bool
  default     = false
}

variable "has_downloads" {
  description = "Enable Downloads"
  type        = bool
  default     = false
}

variable "has_discussions" {
  description = "Enable GitHub Discussions"
  type        = bool
  default     = false
}

variable "vulnerability_alerts" {
  description = "Enable security alerts for vulnerable dependencies"
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# Merge Settings
#------------------------------------------------------------------------------
variable "delete_branch_on_merge" {
  description = "Automatically delete head branches after PR merge"
  type        = bool
  default     = true
}

variable "allow_merge_commit" {
  description = "Allow merge commits"
  type        = bool
  default     = false
}

variable "allow_squash_merge" {
  description = "Allow squash merges"
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Allow rebase merges"
  type        = bool
  default     = false
}

variable "allow_auto_merge" {
  description = "Allow auto-merge on pull requests"
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Repository Initialization
#------------------------------------------------------------------------------
variable "auto_init" {
  description = "Initialize repository with a README"
  type        = bool
  default     = true
}

variable "gitignore_template" {
  description = "Gitignore template to use (e.g., 'Python', 'Node')"
  type        = string
  default     = null
}

variable "license_template" {
  description = "License template to use (e.g., 'mit', 'apache-2.0')"
  type        = string
  default     = null
}

variable "template_repository" {
  description = "Template repository to use"
  type = object({
    owner      = string
    repository = string
  })
  default = null
}

#------------------------------------------------------------------------------
# Default Branch
#------------------------------------------------------------------------------
variable "default_branch" {
  description = "The default branch for the repository"
  type        = string
  default     = null
}

#------------------------------------------------------------------------------
# Branch Protection
#------------------------------------------------------------------------------
variable "branch_protections" {
  description = "Map of branch protection rules"
  type = map(object({
    enforce_admins          = optional(bool, false)
    allows_deletions        = optional(bool, false)
    allows_force_pushes     = optional(bool, false)
    require_signed_commits  = optional(bool, false)
    required_linear_history = optional(bool, false)

    required_status_checks = optional(object({
      strict   = optional(bool, true)
      contexts = optional(list(string), [])
    }))

    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, true)
      restrict_dismissals             = optional(bool, false)
      dismissal_restrictions          = optional(list(string), [])
      require_code_owner_reviews      = optional(bool, false)
      required_approving_review_count = optional(number, 1)
      require_last_push_approval      = optional(bool, false)
    }))
  }))
  default = {}
}

#------------------------------------------------------------------------------
# Team Access
#------------------------------------------------------------------------------
variable "team_permissions" {
  description = "Map of team ID/slug to permission level (pull, triage, push, maintain, admin)"
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for perm in values(var.team_permissions) : contains(["pull", "triage", "push", "maintain", "admin"], perm)
    ])
    error_message = "Team permission must be one of: pull, triage, push, maintain, admin."
  }
}

#------------------------------------------------------------------------------
# Collaborators
#------------------------------------------------------------------------------
variable "collaborators" {
  description = "Map of username to permission level (pull, triage, push, maintain, admin)"
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for perm in values(var.collaborators) : contains(["pull", "triage", "push", "maintain", "admin"], perm)
    ])
    error_message = "Collaborator permission must be one of: pull, triage, push, maintain, admin."
  }
}

#------------------------------------------------------------------------------
# Deploy Keys
#------------------------------------------------------------------------------
variable "deploy_keys" {
  description = "Map of deploy key title to configuration"
  type = map(object({
    key       = string
    read_only = optional(bool, true)
  }))
  default = {}
}

#------------------------------------------------------------------------------
# Webhooks
#------------------------------------------------------------------------------
variable "webhooks" {
  description = "Map of webhook configurations"
  type = map(object({
    url          = string
    content_type = optional(string, "json")
    insecure_ssl = optional(bool, false)
    secret       = optional(string, null)
    active       = optional(bool, true)
    events       = list(string)
  }))
  default = {}
}

#------------------------------------------------------------------------------
# Repository Files
#------------------------------------------------------------------------------
variable "files" {
  description = "Map of file path to file configuration"
  type = map(object({
    content             = string
    branch              = optional(string, "main")
    commit_message      = optional(string, "Managed by Terraform")
    commit_author       = optional(string, "Terraform")
    commit_email        = optional(string, "terraform@example.com")
    overwrite_on_create = optional(bool, true)
  }))
  default = {}
}

#------------------------------------------------------------------------------
# GitHub Actions
#------------------------------------------------------------------------------
variable "actions_secrets" {
  description = "Map of secret name to value for GitHub Actions"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "actions_variables" {
  description = "Map of variable name to value for GitHub Actions"
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# Environments
#------------------------------------------------------------------------------
variable "environments" {
  description = "Map of environment configurations"
  type = map(object({
    reviewers = optional(object({
      teams = optional(list(number), [])
      users = optional(list(number), [])
    }))
    deployment_branch_policy = optional(object({
      protected_branches     = bool
      custom_branch_policies = bool
    }))
  }))
  default = {}
}
