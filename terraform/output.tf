output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks_testcluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_testcluster.kube_config_raw
  sensitive = true
}

output "get_credentials_command" {
  value = "az aks get-credentials --name ${azurerm_kubernetes_cluster.aks_testcluster.name} --resource-group ${azurerm_kubernetes_cluster.aks_testcluster.resource_group_name}"
  description = "Run this command to configure kubectl to use the AKS cluster"
}
