terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.8.0"
    }
  }
}

# create project
resource "mongodbatlas_project" "app" {
  name   = "prj-${var.namespace}"
  org_id = var.atlas_secret.org_id
  # project_owner_id = ""

  # # developers
  # teams {
  #   team_id    = "640fbb3d3b70804145eb8308"
  #   role_names = ["GROUP_DATA_ACCESS_READ_WRITE"]
  # }
  # # administrators
  # teams {
  #   team_id    = "640fbb3d3b70804145eb8308"
  #   role_names = ["GROUP_OWNER"]
  # }


  lifecycle {
    prevent_destroy = true
  }
}

# TODO: use CMK to encrypt 
# # encryption at rest
# resource "mongodbatlas_encryption_at_rest" "app" {
#   project_id = mongodbatlas_project.app.id

#   azure_key_vault = {
#     enabled             = true
#     client_id           = var.azure_secret.client_id
#     azure_environment   = "AZURE"
#     subscription_id     = var.azure_secret.subscription_id
#     resource_group_name = var.resource_group.name
#     key_vault_name      = var.key_vault_name
#     key_identifier      = var.key_identifier
#     secret              = var.azure_secret.client_secret
#     tenant_id           = var.azure_secret.tenant_id
#   }
# }

# create cluster
resource "mongodbatlas_advanced_cluster" "app" {
  project_id = mongodbatlas_project.app.id
  name       = "app"

  backup_enabled                 = true
  pit_enabled                    = true
  termination_protection_enabled = true
  version_release_system         = "CONTINUOUS"

  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    zone_name  = "ZoneName managed by Terraform"

    region_configs {
      electable_specs {
        instance_size = "M10"
        node_count    = 3
      }
      provider_name = "AZURE"
      priority      = 7
      region_name   = "AUSTRALIA_EAST"
      auto_scaling {
        compute_enabled            = true
        compute_min_instance_size  = "M10"
        compute_max_instance_size  = "M20"
        compute_scale_down_enabled = true
        disk_gb_enabled            = true
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
