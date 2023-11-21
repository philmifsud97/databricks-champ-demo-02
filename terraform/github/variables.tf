variable "github_org_url" {
  description = "Github URL"
  type        = string
}

variable "github_pat" {
  description = "string PAT"
  type        = string
}

variable "databricks_pat" {
  description = "string PAT"
  type        = string
}

variable "github_user_name" {
  description = "string User Name"
  type        = string
}

variable "github_repo" {
  description = "Repo name in string"
  type        = string
  default     = "databricks-champ-demo-02-tf"
}

variable "cluster_prefix" {
    description = "cluster name prefix"
    type = string
    default = "Databricks Champ Demo 02 TF"
}

variable "dlt_name_prefix" {
  description = "Prefix for DLT pipelines name"
  type        = string
  default     = "DLT + Files in Repos"
}
