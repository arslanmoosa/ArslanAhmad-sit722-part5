output "djb993rg" {
  value = "${azurerm_resource_group.djb993rg.name}"
}

output "djb993cr" {
  value = "${azurerm_container_registry.djb993cr.name}"
}

output "aks-cluster" {
  value = "${azurerm_kubernetes_cluster.aks-cluster.name}"
}