resource "github_organization_ruleset" "protect_main" {
  count = var.main_branch_protection.enabled ? 1 : 0
  
  name        = "org-protect-main"
  target      = "branch"
  enforcement = "active"
  
  conditions {
    ref_name {
      include = var.main_branch_protection.protected_branches
      exclude = var.main_branch_protection.excluded_branches
    }
  }
  
  rules {
    # Branch protection
    creation                = var.main_branch_protection.prevent_creation
    update                  = var.main_branch_protection.prevent_updates
    deletion                = var.main_branch_protection.prevent_deletion
    required_linear_history = var.main_branch_protection.linear_history
    required_signatures     = var.main_branch_protection.signed_commits
    
    # Pull request requirements
    pull_request {
      required_approving_review_count = var.main_branch_protection.pr_approvals_required
      require_code_owner_review       = var.main_branch_protection.require_code_owners
      dismiss_stale_reviews_on_push   = var.main_branch_protection.dismiss_stale_reviews
    }
    
    # Status checks
    dynamic "required_status_checks" {
      for_each = var.main_branch_protection.require_status_checks ? [1] : []
      
      content {
        strict_required_status_checks_policy = var.main_branch_protection.status_checks_must_be_fresh
        
        dynamic "required_check" {
          for_each = var.main_branch_protection.required_checks
          
          content {
            context = required_check.value
          }
        }
      }
    }
  }
}

# Output the ruleset ID for reference
output "main_branch_protection_id" {
  description = "ID of the main branch protection ruleset"
  value       = var.main_branch_protection.enabled ? github_organization_ruleset.protect_main[0].id : null
}
