variable "github_owner" {
type = string
description = "GitHub user or organization to own the repo"
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
