resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  name                  = var.nodepool_name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = var.nodepool_vm_size
  node_count            = var.nodepool_node_count

  tags = merge(local.merged_tags, {
    Name = var.nodepool_name
    Org  = var.customer
    Environment = var.env
  })
}
