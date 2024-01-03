data "google_compute_subnetwork" "zap" {
  self_link = var.subnet_self_link
}