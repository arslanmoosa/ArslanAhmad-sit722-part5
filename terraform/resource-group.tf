data "azurerm_resource_group" "existing_ampart" {
  name = "ampart5"
}

resource "azurerm_resource_group" "ampart5" {
  count = length(data.azurerm_resource_group.existing_ampart.name) == 0 ? 1 : 0
  name     = "ampart5"
  location = var.location
}