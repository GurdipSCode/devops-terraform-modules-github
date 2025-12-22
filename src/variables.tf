# Organization Information
variable "org_billing_email" {
  description = "Billing email address for the organization"
  type        = string
  default     = "billing@example.com"
}

variable "repositories" {
  description = "Map of GitHub repositories to create"
  type = map(object({
    description = string
    visibility  = string
    
    # Repository Features (optional)
    has_issues      = optional(bool, true)
    has_projects    = optional(bool, false)
    has_wiki        = optional(bool, false)
    has_downloads   = optional(bool, false)
    has_discussions = optional(bool, false)
    
    # Repository Settings (optional)
    is_template               = optional(bool, false)
    allow_merge_commit        = optional(bool, true)
    allow_squash_merge        = optional(bool, true)
    allow_rebase_merge        = optional(bool, true)
    allow_auto_merge          = optional(bool, false)
    delete_branch_on_merge    = optional(bool, true)
    squash_merge_commit_title = optional(string, "COMMIT_OR_PR_TITLE")
    merge_commit_title        = optional(string, "MERGE_MESSAGE")
    
    # Auto-init (optional)
    auto_init          = optional(bool, false)
    gitignore_template = optional(string, null)
    license_template   = optional(string, null)
    
    # Security & Analysis (optional)
    vulnerability_alerts                    = optional(bool, true)
    enable_automated_security_fixes         = optional(bool, true)
    
    # Topics (optional)
    topics = optional(list(string), [])
    
    # Homepage (optional)
    homepage_url = optional(string, null)
    
    # Archive (optional)
    archived = optional(bool, false)
    
    # Branch Protection (optional)
    default_branch = optional(string, "main")
    branch_protection = optional(object({
      pattern                         = optional(string, "main")
      enforce_admins                  = optional(bool, true)
      require_signed_commits          = optional(bool, true)
      required_linear_history         = optional(bool, false)
      require_conversation_resolution = optional(bool, true)
      
      required_status_checks = optional(object({
        strict   = optional(bool, true)
        contexts = optional(list(string), [])
      }), null)
      
      required_pull_request_reviews = optional(object({
        dismiss_stale_reviews           = optional(bool, true)
        require_code_owner_reviews      = optional(bool, true)
        required_approving_review_count = optional(number, 1)
        restrict_dismissals             = optional(bool, false)
      }), null)
      
      restrictions = optional(object({
        users = optional(list(string), [])
        teams = optional(list(string), [])
        apps  = optional(list(string), [])
      }), null)
    }), null)
    
    # Team Access (optional)
    team_permissions = optional(map(string), {})
    
    # Webhooks (optional)
    webhooks = optional(map(object({
      events       = list(string)
      url          = string
      content_type = optional(string, "json")
      insecure_ssl = optional(bool, false)
      active       = optional(bool, true)
      secret       = optional(string, null)
    })), {})
  }))
  
  default = {}
}

# Example default values
variable "default_visibility" {
  description = "Default visibility for repositories"
  type        = string
  default     = "private"
  validation {
    condition     = contains(["public", "private", "internal"], var.default_visibility)
    error_message = "Visibility must be public, private, or internal"
  }
}

variable "enable_security_by_default" {
  description = "Enable security features by default for all repositories"
  type        = bool
  default     = true
}

variable "delete_branch_on_merge_default" {
  description = "Delete head branch after merge by default"
  type        = bool
  default     = true
}


variable "org_company" {
  description = "Company name"
  type        = string
  default     = "My Company"
}

variable "org_blog" {
  description = "Organization blog URL"
  type        = string
  default     = "https://example.com"
}

variable "org_email" {
  description = "Organization contact email"
  type        = string
  default     = "info@example.com"
}

variable "org_twitter_username" {
  description = "Organization Twitter username"
  type        = string
  default     = "mycompany"
}

variable "org_location" {
  description = "Organization location"
  type        = string
  default     = "San Francisco"
}

variable "org_name" {
  description = "Organization display name"
  type        = string
  default     = "My Organization"
}

variable "org_description" {
  description = "Organization description"
  type        = string
  default     = "We build cool stuff"
}

# Repository Defaults
variable "default_repository_permission" {
  description = "Default permission level members have for organization repositories"
  type        = string
  default     = "read"
  validation {
    condition     = contains(["read", "write", "admin", "none"], var.default_repository_permission)
    error_message = "Must be one of: read, write, admin, none"
  }
}

variable "members_can_create_repositories" {
  description = "Whether organization members can create new repositories"
  type        = bool
  default     = true
}

variable "members_can_create_public_repositories" {
  description = "Whether organization members can create public repositories"
  type        = bool
  default     = false
}

variable "members_can_create_private_repositories" {
  description = "Whether organization members can create private repositories"
  type        = bool
  default     = true
}

variable "members_can_create_internal_repositories" {
  description = "Whether organization members can create internal repositories"
  type        = bool
  default     = false
}

variable "members_can_create_pages" {
  description = "Whether organization members can create GitHub Pages"
  type        = bool
  default     = true
}

variable "members_can_fork_private_repositories" {
  description = "Whether organization members can fork private repositories"
  type        = bool
  default     = false
}

# Security Settings
variable "web_commit_signoff_required" {
  description = "Whether web-based commits must be signed off"
  type        = bool
  default     = true
}

variable "advanced_security_enabled_for_new_repositories" {
  description = "Whether GitHub Advanced Security is enabled for new repositories"
  type        = bool
  default     = true
}

variable "dependabot_alerts_enabled_for_new_repositories" {
  description = "Whether Dependabot alerts are enabled for new repositories"
  type        = bool
  default     = true
}

variable "dependabot_security_updates_enabled_for_new_repositories" {
  description = "Whether Dependabot security updates are enabled for new repositories"
  type        = bool
  default     = true
}

variable "dependency_graph_enabled_for_new_repositories" {
  description = "Whether dependency graph is enabled for new repositories"
  type        = bool
  default     = true
}

variable "secret_scanning_enabled_for_new_repositories" {
  description = "Whether secret scanning is enabled for new repositories"
  type        = bool
  default     = true
}

variable "secret_scanning_push_protection_enabled_for_new_repositories" {
  description = "Whether secret scanning push protection is enabled for new repositories"
  type        = bool
  default     = true
}


variable "gpg_key" {
  type = string
  description = "GPG Public key"
}

variable "github_owner" {
type = string
description = "GitHub user or organization to own the repo"
}

variable "github_teams" {
  description = "List of GitHub teams to create in the organization"
  type = list(object({
    name        = string
    description = string
    privacy     = string
  }))
  default = [
    {
      name        = "DevOps"
      description = "DevOps"
      privacy     = "closed"
    },
    {
      name        = "SecOps"
      description = "SecOps"
      privacy     = "closed"
    }
  ]
}


variable "armored_public_key" {
  type = string
  description = "GPG public keys"
}

variable "name" {
type = string
description = "Repository name"
}

variable "description" {
type = string
description = "Repository description"
default = ""
}

variable "repositories" {
  type = map(object({
    allow_merge_commit = bool
    name        = string
    description = string
    homepage_url  = string
    visibility  = string
    has_issues  = bool
  }))
  default = {
    "devops-portfolio" = {
      allow_merge_commit = true
      homepage_url = "https://gurdipsira.dev"
      name        = "dffd"
      description = "Main application repo"
      visibility  = "private"
      has_issues  = true
    }
    "my-lib" = {
      allow_merge_commit = true
      homepage_url = "https://gurdipsira.dev"
      name        = "my-cert"
      description = "Shared library"
      visibility  = "public"
      has_issues  = false
    }
  }
}

variable "visibility" {
type = string
description = "public | private | internal (internal only for orgs with GitHub Enterprise)"
default = "private"
}


variable "default_branch" {
type = string
default = "main"
}
