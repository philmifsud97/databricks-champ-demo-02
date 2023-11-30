data "databricks_node_type" "smallest" {
  local_disk = true
  min_cores   = 4
  gb_per_core = 1
  min_gpus    = 1
  category = "General Purpose"
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "databricks_demo" {
  cluster_name            = "${var.cluster_prefix} (${data.databricks_current_user.me.alphanumeric})"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  spark_conf = {
    # Single-node
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"

  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }

  library {
    pypi {
      package = "nutter"
    }
  }
  library {
    pypi {
      package = "chispa"
    }
  }
  library {
    pypi {
      package = "pytest"
    }
  }

}
