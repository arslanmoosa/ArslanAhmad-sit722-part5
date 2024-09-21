
output "aks-cluster" {
  value = "${azurerm_kubernetes_cluster.aks-cluster.name}"
}