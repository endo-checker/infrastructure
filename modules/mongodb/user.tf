
# create database user
resource "mongodbatlas_database_user" "app" {
  username           = var.atlas_secret.db_user
  password           = var.atlas_secret.db_secret
  project_id         = mongodbatlas_project.app.id
  auth_database_name = "admin"

  roles {
    role_name     = "atlasAdmin" #"readWriteAnyDatabase"
    database_name = "admin"
  }

  scopes {
    name = mongodbatlas_advanced_cluster.app.name
    type = "CLUSTER"
  }
}
