module "dns" {
  source             = "./modules/dns"
  dns_primary_zone   = var.dns_primary_zone_name
  dns_resource_group = var.dns_resource_group
  dns_location       = var.dns_location
}

module "aks" {
  depends_on = [
    module.dns
  ]
  source             = "./modules/aks"
  k8s_resource_group = var.k8s_resource_group
  k8s_cluster_name   = var.k8s_cluster_name
  k8s_dns_prefix     = var.k8s_dns_prefix
  k8s_env            = var.k8s_env
  k8s_location       = var.k8s_location
  k8s_node_count     = var.k8s_node_count
  k8s_version        = var.k8s_version
  k8s_vm_size        = var.k8s_vm_size
}

module "monitoring" {
  source                      = "./modules/monitoring"
  grafana_admin_user          = var.grafana_admin_user
  grafana_admin_password      = var.grafana_admin_password
  helm_host                   = module.aks.host
  helm_client_certificate     = module.aks.client_certificate
  helm_client_key             = module.aks.client_key
  helm_cluster_ca_certificate = module.aks.cluster_ca_certificate
}

# module "tls" {
#   so
# }
