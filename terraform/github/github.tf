#Clone repo for demo and create env variables

resource "null_resource" "github_create_repo" {
  provisioner "local-exec" {
    command = "gh repo create ${var.github_repo} --template=https://github.com/philmifsud97/databricks-champ-demo-02 --public --include-all-branches"
    }

  # triggers = {
  # always_run = "${timestamp()}"
  # }

}

data "github_repository" "repo" {
  full_name = "${var.github_user_name}/${var.github_repo}"

  depends_on = [ null_resource.github_create_repo ]
}

resource "databricks_token" "pat_for_devops" {
  comment          = "Github Demo02 TF (10 days)"
  lifetime_seconds = 864000
}

# #Github dev environment variables

resource "github_repository_environment" "repo_env_dev" {
  repository       = var.github_repo
  environment      = "dev"

  depends_on = [ null_resource.github_create_repo ]
}

resource "github_actions_environment_variable" "clusterid_var_dev" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_dev.environment
  variable_name    = "CLUSTER_ID"
  value            = databricks_cluster.databricks_demo.id

  depends_on = [ databricks_cluster.databricks_demo, null_resource.github_create_repo ]
}

resource "github_actions_environment_variable" "dbhost_var_dev" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_dev.environment
  variable_name    = "DATABRICKS_HOST"
  value            = data.databricks_current_user.me.workspace_url

  depends_on = [ null_resource.github_create_repo ]
}

resource "github_actions_environment_variable" "repodir_var_dev" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_dev.environment
  variable_name    = "REPO_DIRECTORY"
  value            = databricks_repo.demo_in_user_home.path

  depends_on = [  null_resource.github_create_repo ]

}

resource "github_actions_environment_secret" "databricks_pat_dev" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_dev.environment
  secret_name      = "DATABRICKS_TOKEN"
  plaintext_value  = var.github_pat

  depends_on = [ null_resource.github_create_repo ]
}


#Github stage environment variables

resource "github_repository_environment" "repo_env_stg" {
  repository       = var.github_repo
  environment      = "stage"
  

  depends_on = [ null_resource.github_create_repo ]
}

resource "github_actions_environment_variable" "clusterid_var_stg" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_stg.environment
  variable_name    = "CLUSTER_ID"
  value            = databricks_cluster.databricks_demo.id

  depends_on = [ databricks_cluster.databricks_demo ]
}

resource "github_actions_environment_variable" "dbhost_var_stg" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_stg.environment
  variable_name    = "DATABRICKS_HOST"
  value            = data.databricks_current_user.me.workspace_url
}

resource "github_actions_environment_variable" "repodir_var_stg" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_stg.environment
  variable_name    = "REPO_DIRECTORY"
  value            = databricks_repo.demo_in_user_home.path

}

resource "github_actions_environment_secret" "databricks_pat_stg" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.repo_env_stg.environment
  secret_name      = "DATABRICKS_TOKEN"
  plaintext_value  = var.github_pat
}


