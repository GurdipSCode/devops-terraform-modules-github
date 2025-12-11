#------------------------------------------------------------------------------
# Repository Outputs
#------------------------------------------------------------------------------
output "repository" {
  description = "The full repository object"
  value       = github_repository.this
}

output "name" {
  description = "The name of the repository"
  value       = github_repository.this.name
}

output "full_name" {
  description = "The full name of the repository (org/repo)"
  value       = github_repository.this.full_name
}

output "html_url" {
  description = "URL to the repository on GitHub"
  value       = github_repository.this.html_url
}

output "ssh_clone_url" {
  description = "SSH clone URL"
  value       = github_repository.this.ssh_clone_url
}

output "http_clone_url" {
  description = "HTTPS clone URL"
  value       = github_repository.this.http_clone_url
}

output "git_clone_url" {
  description = "Git clone URL"
  value       = github_repository.this.git_clone_url
}

output "node_id" {
  description = "GraphQL node ID of the repository"
  value       = github_repository.this.node_id
}

output "repo_id" {
  description = "GitHub ID of the repository"
  value       = github_repository.this.repo_id
}

#------------------------------------------------------------------------------
# Branch Protection Outputs
#------------------------------------------------------------------------------
output "branch_protections" {
  description = "Map of branch protection resources"
  value       = github_branch_protection.this
}

#------------------------------------------------------------------------------
# Team Access Outputs
#------------------------------------------------------------------------------
output "team_repositories" {
  description = "Map of team repository access resources"
  value       = github_team_repository.this
}

#------------------------------------------------------------------------------
# Environment Outputs
#------------------------------------------------------------------------------
output "environments" {
  description = "Map of repository environment resources"
  value       = github_repository_environment.this
}
