# Create GitHub Organization Rulesets
resource "github_organization_ruleset" "rulesets" {
  for_each = var.organization_rulesets

  name        = each.key
  target      = each.value.target
  enforcement = each.value.enforcement

  # Reference conditions
  conditions {
    ref_name {
      include = each.value.ref_name.include
      exclude = each.value.ref_name.exclude
    }

    # Repository targeting (optional)
    dynamic "repository_name" {
      for_each = each.value.repository_conditions != null && each.value.repository_conditions.repository_name != null ? [each.value.repository_conditions.repository_name] : []
      content {
        include = repository_name.value.include
        exclude = repository_name.value.exclude
      }
    }

    dynamic "repository_id" {
      for_each = each.value.repository_conditions != null && each.value.repository_conditions.repository_id != null ? [each.value.repository_conditions.repository_id] : []
      content {
        repository_ids = repository_id.value.repository_ids
      }
    }

    dynamic "repository_property" {
      for_each = each.value.repository_conditions != null && each.value.repository_conditions.repository_property != null ? [each.value.repository_conditions.repository_property] : []
      content {
        include = repository_property.value.include
        exclude = repository_property.value.exclude
      }
    }
  }

  # Bypass actors (optional)
  dynamic "bypass_actors" {
    for_each = each.value.bypass_actors
    content {
      actor_id    = bypass_actors.value.actor_id
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = bypass_actors.value.bypass_mode
    }
  }

  # Rules
  rules {
    # Basic protection rules
    creation                = each.value.rules.creation
    update                  = each.value.rules.update
    deletion                = each.value.rules.deletion
    required_linear_history = each.value.rules.required_linear_history
    required_signatures     = each.value.rules.required_signatures
    non_fast_forward        = each.value.rules.non_fast_forward

    # Pull request rules
    dynamic "pull_request" {
      for_each = each.value.rules.pull_request != null ? [each.value.rules.pull_request] : []
      content {
        required_approving_review_count   = pull_request.value.required_approving_review_count
        dismiss_stale_reviews_on_push     = pull_request.value.dismiss_stale_reviews_on_push
        require_code_owner_review         = pull_request.value.require_code_owner_review
        require_last_push_approval        = pull_request.value.require_last_push_approval
        required_review_thread_resolution = pull_request.value.required_review_thread_resolution
      }
    }

    # Required status checks
    dynamic "required_status_checks" {
      for_each = each.value.rules.required_status_checks != null ? [each.value.rules.required_status_checks] : []
      content {
        strict_required_status_checks_policy = required_status_checks.value.strict

        dynamic "required_check" {
          for_each = required_status_checks.value.required_status_checks
          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }
      }
    }

    # Commit message pattern
    dynamic "commit_message_pattern" {
      for_each = each.value.rules.commit_message_pattern != null ? [each.value.rules.commit_message_pattern] : []
      content {
        operator = commit_message_pattern.value.operator
        pattern  = commit_message_pattern.value.pattern
        name     = commit_message_pattern.value.name
        negate   = commit_message_pattern.value.negate
      }
    }

    # Commit author email pattern
    dynamic "commit_author_email_pattern" {
      for_each = each.value.rules.commit_author_email_pattern != null ? [each.value.rules.commit_author_email_pattern] : []
      content {
        operator = commit_author_email_pattern.value.operator
        pattern  = commit_author_email_pattern.value.pattern
        name     = commit_author_email_pattern.value.name
        negate   = commit_author_email_pattern.value.negate
      }
    }

    # Committer email pattern
    dynamic "committer_email_pattern" {
      for_each = each.value.rules.committer_email_pattern != null ? [each.value.rules.committer_email_pattern] : []
      content {
        operator = committer_email_pattern.value.operator
        pattern  = committer_email_pattern.value.pattern
        name     = committer_email_pattern.value.name
        negate   = committer_email_pattern.value.negate
      }
    }

    # Branch name pattern
    dynamic "branch_name_pattern" {
      for_each = each.value.rules.branch_name_pattern != null ? [each.value.rules.branch_name_pattern] : []
      content {
        operator = branch_name_pattern.value.operator
        pattern  = branch_name_pattern.value.pattern
        name     = branch_name_pattern.value.name
        negate   = branch_name_pattern.value.negate
      }
    }

    # Tag name pattern
    dynamic "tag_name_pattern" {
      for_each = each.value.rules.tag_name_pattern != null ? [each.value.rules.tag_name_pattern] : []
      content {
        operator = tag_name_pattern.value.operator
        pattern  = tag_name_pattern.value.pattern
        name     = tag_name_pattern.value.name
        negate   = tag_name_pattern.value.negate
      }
    }

    # Required workflows
    dynamic "required_workflows" {
      for_each = each.value.rules.required_workflows != null ? [each.value.rules.required_workflows] : []
      content {
        dynamic "required_workflow" {
          for_each = required_workflows.value.required_workflows
          content {
            path          = required_workflow.value.path
            repository_id = required_workflow.value.repository_id
            ref           = required_workflow.value.ref
          }
        }
      }
    }

    # File path restrictions
    dynamic "file_path_restriction" {
      for_each = each.value.rules.file_path_restriction != null ? [each.value.rules.file_path_restriction] : []
      content {
        restricted_file_paths = file_path_restriction.value.restricted_file_paths
      }
    }

    # File extension restrictions
    dynamic "file_extension_restriction" {
      for_each = each.value.rules.file_extension_restriction != null ? [each.value.rules.file_extension_restriction] : []
      content {
        restricted_file_extensions = file_extension_restriction.value.restricted_file_extensions
      }
    }

    # Maximum file path length
    dynamic "max_file_path_length" {
      for_each = each.value.rules.max_file_path_length != null ? [each.value.rules.max_file_path_length] : []
      content {
        max_file_path_length = max_file_path_length.value.max_file_path_length
      }
    }

    # Maximum file size
    dynamic "max_file_size" {
      for_each = each.value.rules.max_file_size != null ? [each.value.rules.max_file_size] : []
      content {
        max_file_size = max_file_size.value.max_file_size
      }
    }

    # Required deployments
    dynamic "required_deployments" {
      for_each = each.value.rules.required_deployments != null ? [each.value.rules.required_deployments] : []
      content {
        required_deployment_environments = required_deployments.value.required_deployment_environments
      }
    }
  }
}
