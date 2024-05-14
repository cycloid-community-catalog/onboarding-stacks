output "nodepool_id" {
  description = "The ID of the Kubernetes Cluster Node Pool."
  value       = resource.azurerm_kubernetes_cluster_node_pool.nodepool.id
}