terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.42.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
}
  }

# https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs

provider "github" {
  token = var.github_pat
}

provider "databricks" {
}
