resource "azurerm_resource_group" "ampart5" {
  name     = "ampart5"
  location = var.location
}

resource "azurerm_resource_group" "amkubpart5" {
  name     = "amkubpart5"
  location = var.location
}

resource "azurerm_resource_group" "deakinuni" {
  name     = "deakinuni"
  location = var.location
}
