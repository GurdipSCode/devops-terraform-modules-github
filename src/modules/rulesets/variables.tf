variable "organization_rulesets" {
  description = "Map of GitHub organization rulesets to create"
  type = map(object({
    # Basic Settings
    target      = string # "branch", "tag", or "push"
    enforcement = string # "disabled", "active", "evaluate"

    # Conditions
    ref_name = object({
      include = list(string)
      exclude = optional(list(string), [])
    })

    # Repository Targeting (optional)
    repository_conditions = optional(object({
      repository_name = optional(object({
        include = optional(list(string), [])
        exclude = optional(list(string), [])
      }), null)
      repository_id = optional(object({
        repository_ids = optional(list(number), [])
      }), null)
      repository_property = optional(object({
        include = optional(list(string), [])
        exclude = optional(list(string), [])
      }), null)
    }), null)

    # Bypass Actors (optional)
    bypass_actors = optional(list(object({
      actor_id    = number
      actor_type  = string # "RepositoryRole", "Team", "Integration", "OrganizationAdmin"
      bypass_mode = string # "always", "pull_request"
    })), [])

    # Rules
    rules = object({
      # Branch/Tag Protection
      creation                = optional(bool, false)
      update                  = optional(bool, false)
      deletion                = optional(bool, false)
      required_linear_history = optional(bool, false)
      required_signatures     = optional(bool, false)

      # Pull Request Rules
      pull_request = optional(object({
        required_approving_review_count   = optional(number, 1)
        dismiss_stale_reviews_on_push     = optional(bool, true)
        require_code_owner_review         = optional(bool, false)
        require_last_push_approval        = optional(bool, false)
        required_review_thread_resolution = optional(bool, false)
      }), null)

      # Status Checks
      required_status_checks = optional(object({
        strict                          = optional(bool, true)
        required_status_checks          = optional(list(object({
          context        = string
          integration_id = optional(number, null)
        })), [])
      }), null)

      # Commit Rules
      commit_message_pattern = optional(object({
        operator = string # "starts_with", "ends_with", "contains", "regex"
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      commit_author_email_pattern = optional(object({
        operator = string # "starts_with", "ends_with", "contains", "regex"
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      committer_email_pattern = optional(object({
        operator = string # "starts_with", "ends_with", "contains", "regex"
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      # Branch Name Pattern
      branch_name_pattern = optional(object({
        operator = string # "starts_with", "ends_with", "contains", "regex"
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      # Tag Name Pattern
      tag_name_pattern = optional(object({
        operator = string # "starts_with", "ends_with", "contains", "regex"
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      # Workflow Requirements
      required_workflows = optional(object({
        required_workflows = list(object({
          path          = string
          repository_id = number
          ref           = optional(string, null)
        }))
      }), null)

      # File Path Restrictions
      file_path_restriction = optional(object({
        restricted_file_paths = list(string)
      }), null)

      # File Extension Restrictions
      file_extension_restriction = optional(object({
        restricted_file_extensions = list(string)
      }), null)

      # Maximum File Path Length
      max_file_path_length = optional(object({
        max_file_path_length = number
      }), null)

      # Maximum File Size
      max_file_size = optional(object({
        max_file_size = number # in MB
      }), null)

      # Require Non-Fast-Forward
      non_fast_forward = optional(bool, false)

      # Require Deployments to Succeed
      required_deployments = optional(object({
        required_deployment_environments = list(string)
      }), null)
    })
  }))

  default = {}

  validation {
    condition = alltrue([
      for ruleset in var.organization_rulesets :
      contains(["branch", "tag", "push"], ruleset.target)
    ])
    error_message = "Target must be 'branch', 'tag', or 'push'"
  }

  validation {
    condition = alltrue([
      for ruleset in var.organization_rulesets :
      contains(["disabled", "active", "evaluate"], ruleset.enforcement)
    ])
    error_message = "Enforcement must be 'disabled', 'active', or 'evaluate'"
  }
}
