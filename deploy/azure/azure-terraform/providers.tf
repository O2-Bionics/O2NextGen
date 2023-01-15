
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.o2nextgen-aks.kube_config.0.cluster_ca_certificate)
}

provider "azuread" {
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
provider "tls" {}
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  backend "azure" {
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "=2.8.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.5.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
    random = {
      source = "hashicorp/random"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}