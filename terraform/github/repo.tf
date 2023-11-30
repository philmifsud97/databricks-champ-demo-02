data "databricks_current_user" "me" {
}

resource "databricks_git_credential" "global" {
  git_provider          = "gitHub"
  git_username          = var.github_user_name
  personal_access_token = var.github_pat
  force                 = true
}

resource "databricks_repo" "demo_in_user_home" {
  depends_on = [databricks_git_credential.global, null_resource.github_create_repo]
  url        = "https://github.com/${var.github_user_name}/${var.github_repo}.git"
  path       = "${data.databricks_current_user.me.repos}/demo02-tf-dev"
  branch     = "releases"
}

## Error: cannot create repo: Top-level folder can only contain repos

resource "databricks_repo" "demo_in_staging" {
  depends_on = [databricks_git_credential.global, null_resource.github_create_repo]
  url        = "https://github.com/${var.github_user_name}/${var.github_repo}.git"
  path       = "${data.databricks_current_user.me.repos}/demo02-tf-stg"
  branch     = "releases"
}

resource "databricks_repo" "demo_in_prod" {
  depends_on = [databricks_git_credential.global, null_resource.github_create_repo]
  url        = "https://github.com/${var.github_user_name}/${var.github_repo}.git"
  path       = "${data.databricks_current_user.me.repos}/demo02-tf-prod"
  branch     = "releases"
}
