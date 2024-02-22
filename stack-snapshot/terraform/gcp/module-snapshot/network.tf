data "google_compute_subnetwork" "snapshot" {
  self_link = var.subnet_self_link
}