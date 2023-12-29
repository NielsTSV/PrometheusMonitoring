# Introduction 
This project will be a mongo-db helm deployment, monitored with prometheus and grafana. The resources are deployed with Terraform, and the deployments run on Azure Kubernetes Service.

# 1. Requirements
- Logged in Azure CLI
- A resource group, storage account and storage container already created for the state file.

# 2. Deployment

1. Deploy Azure Resources */terraform*
    1. Review planned resource deployment
        - `terraform plan`
    2. Deploy Azure resources: 
        - `terraform apply`
2. Connect to K8s deployment
    1. Use following command to connect to K8s cluster
        - `az aks get-credentials --name {azurerm_kubernetes_cluster.aks_testcluster.name} --resource-group ${azurerm_kubernetes_cluster.aks_testcluster.resource_group_name}`
    2. Verify which cluster is connected
        - `kubectl config get-contexts`

3. Deploy K8s deployments with Helm
    1. Prometheus monitoring stack
        - `helm install <my-release> ./kube-prometheus-stack`
    2. Mongodb
        - `helm install <my-release> ./mongodb`
    3. Mongodb exporter
        - `helm install <my-release> ./mongodb-exporter`


# 3. Resources
## Azure
The resources are deployed with Terraform on Azure. Names and settings can be adjusted in */terraform/variables.tf*. The resources include:    
- resource_group = "rg-k8s-testcluster"
- storage_account = "sak8stestcluster"
- storage_container = "sc-k8s-testcluster"
- virtual_network = "vn_k8s_testcluster"
- subnet = "subnet_k8s_testcluster"
- aks_cluster = "aks_testcluster"
- aks_network_security_group = "aks-nsg"

## Helm
Prometheus and Grafana
- Monitoring deployment including prometheus for pulling data from exporters, and grafana as dashboarding solution. Every deployment that has an exporter is picked up by prometheus monitoring.

MongoDB
- MongoDB database deployment

MongoDB exporter
- Exporter exposing mongodb to Prometheus monitoring



