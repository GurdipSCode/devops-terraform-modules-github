resource "github_branch_protection" "default" {
repository_id = github_repository.this.node_id
pattern = var.default_branch


required_status_checks {
strict = true
contexts = []
}


enforce_admins = true


required_pull_request_reviews {
dismissal_restrictions = {}
dismiss_stale_reviews = true
require_code_owner_reviews = false
required_approving_review_count = 1
}


restrictions {
users = []
teams = []
apps = []
}
}
