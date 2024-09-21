
resource "azurerm_resource_group" "deakinuni" {
  name     = var.app_name
  location = var.location
}