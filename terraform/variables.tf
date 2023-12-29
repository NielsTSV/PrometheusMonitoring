variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "North Europe"
}

variable "resource_names" {
  description = "Azure resource names"
  type        = map(string)
  default     = {
    resource_group = "rg-k8s-testcluster"
    storage_account = "sak8stestcluster"
    storage_container = "sc-k8s-testcluster"
    virtual_network = "vn_k8s_testcluster"
    subnet = "subnet_k8s_testcluster"
    aks_cluster = "aks_testcluster"
    aks_network_security_group = "aks-nsg"
  }
}

variable "aks-cluster-setting" {
  description = "AKS cluster settings"
  type        = map(string)
  default     = {
    vm_size = "Standard_D2_v2" # North Europe $0.132 per hour
    node_count = "1"
    dns_prefix = "dnstestcluster"
  }
}

variable "networking_rule_inbound" {
  description = "Azure resource names"
  type        = map(string)
  default     = {
    allow_ip = "84.30.66.163/32"
  }
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {
    environment = "development"
    project     = "k8s_testcluster"
    owner       = ""
  }
}

