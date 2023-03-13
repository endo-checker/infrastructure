
# -----------------------------------------------------------------------------
# Remove from state
# -----------------------------------------------------------------------------
terraform state rm 'module.elastic.ec_deployment.yente'
terraform state rm 'module.github["auth"].github_repository_environment.repo_env'

module.github["check"].github_actions_environment_secret.odic["AZURE_SUBSCRIPTION_ID"]
module.github["check"].github_actions_environment_secret.odic["AZURE_TENANT_ID"]
module.github.azuread_application_federated_identity_credential.repo

# -----------------------------------------------------------------------------
# Taint/untaint
# -----------------------------------------------------------------------------
terraform taint module.container-app.azapi_resource.dapr-yente
terraform taint 'module.services.null_resource.deploy["document"]'

terraform untaint module.elastic.ec_deployment.yente

# -----------------------------------------------------------------------------
# Import state
# -----------------------------------------------------------------------------
terraform import 'azurerm_resource_group.platform' "/subscriptions/2da318e2-604b-4f60-8984-b801b824a602/resourceGroups/rg-platform"

# mongodb
terraform import 'module.mongodb.mongodbatlas_project.app' "625648897160cc761bec3ffa"
terraform import 'module.mongodb.mongodbatlas_advanced_cluster.app' "63215cefa0008e463ca280e3-app"
# {project_id}-{private_link_id}-{provider_name}-{region}
terraform import 'module.mongodb.mongodbatlas_privatelink_endpoint.app' "625648897160cc761bec3ffa-62f1e20b92f5575ad89966ca-AZURE-australiaeast"
# {project_id}--{private_link_id}--{endpoint_service_id}--{provider_name}
terraform import 'module.mongodb.mongodbatlas_privatelink_endpoint_service.app' "625648897160cc761bec3ffa--62f1e20b92f5575ad89966ca--/subscriptions/1278fa29-0ee5-4f10-a568-d00d37a86e03/resourceGroups/app-ticc-dev-ae-rg/providers/Microsoft.Network/privateEndpoints/pl-mongodb-ticc-dev--AZURE"
terraform import 'module.mongodb.mongodbatlas_database_user.app' "625648897160cc761bec3ffa-dbUser-admin"

# elasticsearch
terraform import 'module.elastic.ec_deployment.yente' 0651f8258ec73f51542cb3b55cf89f5d

terraform import 'module.api-mgr.azurerm_monitor_diagnostic_setting.apimgr' "/subscriptions/4e6ec3dd-7f2a-4679-86fc-1cc8297b48cd/resourceGroups/app-ticc-stg-ae-rg/providers/Microsoft.ApiManagement/service/apim-ticc-stg/providers/microsoft.insights/diagnosticSettings/ApiManagerLogs"
 