variable "github_owner" {
type = string
description = "GitHub user or organization to own the repo"
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


variable "visibility" {
type = string
description = "public | private | internal (internal only for orgs with GitHub Enterprise)"
default = "private"
}


variable "default_branch" {
type = string
default = "main"
}
