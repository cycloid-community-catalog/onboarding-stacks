resource "google_compute_network" "compute" {
  name = "${var.customer}-${var.project}-${var.env}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "compute" {
  name          = "${var.customer}-${var.project}-${var.env}"
  ip_cidr_range = "10.21.0.0/16"
  network       = google_compute_network.compute.id
}