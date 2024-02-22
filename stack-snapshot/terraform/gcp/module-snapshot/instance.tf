resource "google_compute_firewall" "snapshot" {
  name    = "${var.customer}-${var.project}-${var.env}"
  network = data.google_compute_subnetwork.snapshot.network

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "snapshot" {
  name           = "${var.customer}-${var.project}-${var.env}"
  machine_type   = var.vm_machine_type
  can_ip_forward = false

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = var.vm_disk_size
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.snapshot.name

    access_config {
      // Ephemeral public IP
      network_tier = "STANDARD"
    }
  }

  metadata_startup_script = templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      # project = var.project
      # env = var.env
    }
  )

  labels = merge(local.merged_tags, {
    role       = "snapshot"
  })
}