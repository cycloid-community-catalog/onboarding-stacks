output "admin_client_certificate" {
  description = "The `client_certificate` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value       = module.aks.admin_client_certificate
}

output "admin_client_key" {
  description = "The `client_key` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
  value       = module.aks.admin_client_key
}

output "admin_cluster_ca_certificate" {
  description = "The `cluster_ca_certificate` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  value       = module.aks.admin_cluster_ca_certificate
}

output "admin_host" {
  description = "The `cluster_ca_certificate` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  value       = module.aks.admin_host
}

output "admin_password" {
  description = "The `password` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A password or token used to authenticate to the Kubernetes cluster."
  value       = module.aks.admin_password
}

output "admin_username" {
  description = "The `username` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A username used to authenticate to the Kubernetes cluster."
  value       = module.aks.admin_password
}

output "kube_admin_config_raw" {
  description = "The `azurerm_kubernetes_cluster`'s `kube_admin_config_raw` argument. Raw Kubernetes config for the admin account to be used by [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled."
  value       = module.aks.kube_admin_config_raw
}

output "aks_id" {
  description = "The `azurerm_kubernetes_cluster`'s id."
  value       = module.aks.aks_id
}

output "aks_name" {
  description = "The `aurerm_kubernetes-cluster`'s name."
  value       = module.aks.aks_name
}