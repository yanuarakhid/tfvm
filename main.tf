resource "google_compute_instance" "vm" {
  project      = "datalabs-hs"
  zone         = "asia-southeast1-b"
  name         = "vm-tf-1"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      size  = 50
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = "vpc-network-tf"
    subnetwork = google_compute_subnetwork.network-tf-subnet.name # Replace with a reference or self link to your subnet, in quotes
  }
}

