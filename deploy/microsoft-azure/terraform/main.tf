provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_container_registry" "acr" {
  name                = "o2ngacr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_resource_group" "rg" {
  name     = "products-group"
  location = "WestUS3" #centralus
}

resource "azurerm_dns_zone" "o2bus-public-zone" {
  name                = "o2bus.com"
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_dns_zone" "pfrcenter-public-zone" {
  name = "pfr-centr.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_kubernetes_cluster" "aks" {
    name = "o2ng-aks"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix = "o2ngaks"

    default_node_pool { 
      name = "system"
      node_count = 1
      vm_size    = "Standard_B2s"
      availability_zones = [1, 2, 3]
      enable_auto_scaling = false
    }

    identity {
        type = "SystemAssigned"
    }

    tags = {
        Environment = "Production"
    }
    network_profile {
        load_balancer_sku = "Standard"
        network_plugin    = "kubenet" # azure (CNI)
    }
}