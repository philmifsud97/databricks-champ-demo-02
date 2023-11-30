This directory contains Terraform code to setup a Databricks champions demo 01 project on github.  To do that, you need to create a file `terraform.tfvars` with following variables:

* `github_org_url`   - URL of your Azure DevOps instance, like, `https://dev.azure.com/company_name`.
* `github_pat`       - Azure DevOps personal access token (PAT) obtained as described in [documentation](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/guides/authenticating_using_the_personal_access_token).  This PAT will be used to create a project in your Azure DevOps organization, and will be set inside Databricks workspace.
* `github_user_name` - your user name inside Azure DevOps organization.

And then execute `terraform apply` (use `terraform plan` to understand what changes will be made).

The code performs following actions:

* Creates a new Github Git repository by cloning this demo.
* Set ups Git credential in Databricks workspace using provided Github PAT.
* Creates 3 Databricks checkouts in the current user's folder with names `demo01-tf-dev`, `demo01-tf-stg`, and `demo01-tf-prod` to emulate transition between different stages.
* Creates a Databricks cluster that will be used to execute the tests.
* Creates a temporary Databricks Personal Access Token (PAT) that will be used to authenticate to Databricks workspace from the build pipeline.
* Creates a Databricks Workflow Job for Integration testing
* Github actions contains all the relevant 

After code is executed, you will have fully configured repositories & build pipeline.  Follow instructions from the [top-level README](../../README.md) to setup release pipeline.


Limitations:

* This code doesn't setup release pipeline as no corresponding functionality is available.
