provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg_k8s_testcluster" {
  name     = var.resource_names["resource_group"]
  location = var.region
  tags     = var.common_tags
}

resource "azurerm_storage_account" "sa_k8s_testcluster" {
  name                     = var.resource_names["storage_account"]
  resource_group_name      = azurerm_resource_group.rg_k8s_testcluster.name
  location                 = azurerm_resource_group.rg_k8s_testcluster.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.common_tags
}

resource "azurerm_storage_container" "sc_k8s_testcluster" {
  name                  = var.resource_names["storage_container"]
  storage_account_name  = azurerm_storage_account.sa_k8s_testcluster.name
  container_access_type = "private"
}

resource "azurerm_virtual_network" "vn_k8s_testcluster" {
  name                = var.resource_names["virtual_network"]
  resource_group_name = azurerm_resource_group.rg_k8s_testcluster.name
  location            = azurerm_resource_group.rg_k8s_testcluster.location
  address_space       = ["10.0.0.0/16"]
  tags                = var.common_tags
}

resource "azurerm_subnet" "subnet_k8s_testcluster" {
  name                 = var.resource_names["subnet"]
  resource_group_name  = azurerm_resource_group.rg_k8s_testcluster.name
  virtual_network_name = azurerm_virtual_network.vn_k8s_testcluster.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks_testcluster" {
  name                = var.resource_names["aks_cluster"]
  location            = azurerm_resource_group.rg_k8s_testcluster.location
  resource_group_name = azurerm_resource_group.rg_k8s_testcluster.name
  dns_prefix          = var.aks-cluster-setting["dns_prefix"]
  tags                = var.common_tags

  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.2.0.0/16"  # Choose a CIDR that does not overlap with your VNet/subnet
    dns_service_ip     = "10.2.0.10"    # This should be an IP in your service CIDR
  }

  default_node_pool {
    name       = "defaultnode"
    node_count = var.aks-cluster-setting["node_count"]
    vm_size    = var.aks-cluster-setting["vm_size"]
    vnet_subnet_id = azurerm_subnet.subnet_k8s_testcluster.id
  }

  identity {
    type = "SystemAssigned"
  }
}