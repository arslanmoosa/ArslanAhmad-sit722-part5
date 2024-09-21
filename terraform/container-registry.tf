data "azurerm_container_registry" "existing_registry" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.ampart5.name
}

resource "azurerm_container_registry" "container_registry" {
  count               = length(data.azurerm_container_registry.existing_registry.name) == 0 ? 1 : 0
  name                = var.app_name
  resource_group_name = azurerm_resource_group.ampart5.name
  location            = var.location
  admin_enabled       = true
  sku                 = "Basic"
}
