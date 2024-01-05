resource "google_compute_network" "vpc-vm-tf" {
  name                    = "vpc-network-tf"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "network-tf-subnet" {
  name          = "network-tf-subnet"
  ip_cidr_range = "10.255.210.0/24"
  network       = google_compute_network.vpc-vm-tf.name
  region        = "asia-southeast1"
}

resource "google_compute_firewall" "rules" {
  name    = "allow-ssh-icmp"
  network = "vpc-network-tf" # Replace with a reference or self link to your network, in quotes
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["35.235.240.0/20", "10.255.215.0/24"]
}
