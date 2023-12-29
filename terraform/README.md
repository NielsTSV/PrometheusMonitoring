### VM Pricing
With the following link, you can find the possible VM's and their specs
- https://learn.microsoft.com/en-gb/azure/virtual-machines/dv2-dsv2-series 
Here you can find the pricing of the selected VM:
- https://azure.microsoft.com/en-gb/pricing/calculator/


### Networking
The default mode of AKS is that the AKS API is publicly reachable.
- Restrict access to the AKS API with a NSG and NSG rules.
- Services on the cluster will automatically be exposed by virtue of the services that are deployed.
