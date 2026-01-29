variable "main_branch_protection" {
  description = "Configuration for main branch protection ruleset"
  type = object({
    # Basic settings
    enabled = bool

    # Branch references
    protected_branches = list(string)
    excluded_branches  = optional(list(string), [])

    # Protection rules
    prevent_creation  = bool
    prevent_updates   = bool
    prevent_deletion  = bool
    linear_history    = bool
    signed_commits    = bool

    # Pull request requirements
    pr_approvals_required = number
    require_code_owners   = bool
    dismiss_stale_reviews = bool

    # Status checks
    require_status_checks       = bool
    status_checks_must_be_fresh = bool
    required_checks             = list(string)
  })

  default = {
    enabled            = true
    protected_branches = ["refs/heads/main"]
    excluded_branches  = []

    prevent_creation  = true
    prevent_updates   = true
    prevent_deletion  = true
    linear_history    = true
    signed_commits    = true

    pr_approvals_required = 1
    require_code_owners   = true
    dismiss_stale_reviews = true

    require_status_checks       = true
    status_checks_must_be_fresh = true
    required_checks             = []
  }
}
