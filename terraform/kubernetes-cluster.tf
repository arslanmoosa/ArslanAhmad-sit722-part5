data "azurerm_kubernetes_cluster" "existing_cluster" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.ampart5.name
}

resource "azurerm_kubernetes_cluster" "cluster" {
  count = length(data.azurerm_kubernetes_cluster.existing_cluster.name) == 0 ? 1 : 0
  name                = var.app_name
  location            = var.location
  resource_group_name = azurerm_resource_group.ampart5.name
  dns_prefix          = var.app_name
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "role_assignment" {
  principal_id                     = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.container_registry.id
  skip_service_principal_aad_check = true
}