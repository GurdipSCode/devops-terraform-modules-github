resource "github_branch_protection" "default" {
  for_each = github_repository.repos

  repository_id = each.value.node_id
  pattern       = each.value.default_branch

  required_status_checks {
    strict   = true
    contexts = []
  }

  enforce_admins = true

  required_pull_request_reviews {
    dismissal_restrictions          = {}
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = false
    required_approving_review_count = 1
  }

  restrictions {
    users = []
    teams = []
    apps  = []
  }
}