resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  name                  = "${var.project}-${var.env}"
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = var.nodepool_vm_size
  node_count            = var.nodepool_node_count

  tags = merge(local.merged_tags, {
    Name = "${var.project}-${var.env}"
    Org  = var.customer
    Environment = var.env
  })
}
