# devops-terraform-modules-github

[![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![GitHub](https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white)](https://github.com/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D1.7-623CE4)](https://www.terraform.io/)

[![Build Status](https://badge.buildkite.com/sample.svg)](https://buildkite.com/)
[![tfsec](https://img.shields.io/badge/tfsec-passing-brightgreen.svg)](https://github.com/aquasecurity/tfsec)
[![TFLint](https://img.shields.io/badge/TFLint-passing-brightgreen.svg)](https://github.com/terraform-linters/tflint)
[![Checkov](https://img.shields.io/badge/Checkov-passing-brightgreen.svg)](https://www.checkov.io/)

## Overview

Terraform module for managing GitHub organization resources including repositories, teams, branch protection rules, and organization settings.

## Features

- 🏢 Organization settings management
- 📦 Repository provisioning via map
- 🔒 Branch protection rules
- 👥 Team management
- 🔑 Secrets and variables
- 📋 Rulesets

## Usage
```hcl
module "github" {
  source = "git::https://github.com/your-org/terraform-github.git?ref=v1.0.0"

  repositories = {
    "my-app" = {
      description    = "Main application"
      visibility     = "private"
      default_branch = "main"
    }
    "my-lib" = {
      description    = "Shared library"
      visibility     = "private"
      default_branch = "main"
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=flat&logo=terraform&logoColor=white) | >= 1.7 |
| ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=flat&logo=github&logoColor=white) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| `github` | ~> 6.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `repositories` | Map of repositories to create | `map(object)` | `{}` | no |
| `default_branch` | Default branch name | `string` | `"main"` | no |
| `enforce_admins` | Enforce branch protection for admins | `bool` | `true` | no |
| `required_approvals` | Number of required PR approvals | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| `repository_ids` | Map of repository names to node IDs |
| `repository_urls` | Map of repository names to URLs |

## Development
```bash
# Format
terraform fmt -recursive

# Validate
terraform validate

# Lint
tflint --recursive

# Security scan
tfsec .
```

## License

MIT
