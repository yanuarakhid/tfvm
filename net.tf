resource "google_compute_network" "vpc-vm-tf" {
  name                    = "vpc-network-tf"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "network-tf-subnet" {
  name          = "network-tf-subnet"
  ip_cidr_range = "192.168.88.0/24"
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
  source_ranges = ["35.235.240.0/20", "192.168.88.0/24"]
}

resource "google_compute_router" "router" {
  name    = "my-router-tf"
  region  = google_compute_subnetwork.network-tf-subnet.region
  network = google_compute_network.vpc-vm-tf.name
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-tf-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
