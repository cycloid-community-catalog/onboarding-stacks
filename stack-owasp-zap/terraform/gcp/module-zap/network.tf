resource "google_compute_network" "zap" {
  name =  "${var.customer}-${var.project}-${var.env}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "zap" {
  name          = "${var.customer}-${var.project}-${var.env}-subnet"
  ip_cidr_range = "10.123.0.0/16"
  network       = google_compute_network.zap.id
}