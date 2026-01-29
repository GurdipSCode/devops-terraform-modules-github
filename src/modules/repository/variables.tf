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
