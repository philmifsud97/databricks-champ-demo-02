
resource "databricks_job" "job_integration_test" {
  depends_on = [ databricks_repo.demo_in_staging,  databricks_cluster.databricks_demo  ]

  name = "Databricks Demo 02 Integration Test TF"

  task {
    task_key = "Unit_Test_Notebook"

    existing_cluster_id = databricks_cluster.databricks_demo.id

    notebook_task {
      notebook_path = "${data.databricks_current_user.me.repos}/demo02-tf-stg/tests/unit-notebooks/test_column_helpers"
    }
  }

  task {
    task_key = "Unit_Test_local"

    depends_on {
      task_key = "Unit_Test_Notebook"
    }

    existing_cluster_id = databricks_cluster.databricks_demo.id

    spark_python_task {
      python_file = "${data.databricks_current_user.me.repos}/demo02-tf-stg/tests/unit-local/test_columns_helpers_script"
    }
  }

}