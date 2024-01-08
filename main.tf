variable "instance_count" {
  default = 3 # Change the number of instances as desired
}

# Create instances for each environment using for_each loop with the map
resource "google_compute_instance" "dev" {
  count        = var.instance_count
  name         = "dev-vm-${count.index + 1}"
  hostname     = "dev-vm-${count.index + 1}"
  machine_type = "e2-micro"
  zone         = "asia-southeast1-b"

  # Customize other settings as needed
  # Example: Boot disk, network interface, etc.
  boot_disk {
    initialize_params {
      size  = 20
      image = "debian-cloud/debian-11"
    }
  }
  # USING IP-PUBLIC
  # network_interface {
  #   network = "default"
  #   access_config {}
  # }

  network_interface {
    network    = "vpc-network-tf"
    subnetwork = google_compute_subnetwork.network-tf-subnet.name # Replace with a reference or self link to your subnet, in quotes
  }
}


resource "google_compute_instance" "staging" {
  count        = var.instance_count
  name         = "staging-vm-${count.index + 1}"
  hostname     = "staging-vm-${count.index + 1}"
  machine_type = "e2-micro"
  zone         = "asia-southeast1-b"

  # Customize other settings as needed
  # Example: Boot disk, network interface, etc.
  boot_disk {
    initialize_params {
      size  = 20
      image = "debian-cloud/debian-11"
    }
  }
  # USING IP-PUBLIC
  # network_interface {
  #   network = "default"
  #   access_config {}
  # }

  network_interface {
    network    = "vpc-network-tf"
    subnetwork = google_compute_subnetwork.network-tf-subnet.name # Replace with a reference or self link to your subnet, in quotes
  }
}


resource "google_compute_instance" "production" {
  count        = var.instance_count
  name         = "prod-vm-${count.index + 1}"
  hostname     = "prod-vm-${count.index + 1}"
  machine_type = "e2-micro"
  zone         = "asia-southeast1-b"

  # Customize other settings as needed
  # Example: Boot disk, network interface, etc.
  boot_disk {
    initialize_params {
      size  = 20
      image = "debian-cloud/debian-11"
    }
  }
  # USING IP-PUBLIC
  # network_interface {
  #   network = "default"
  #   access_config {}
  # }

  network_interface {
    network    = "vpc-network-tf"
    subnetwork = google_compute_subnetwork.network-tf-subnet.name # Replace with a reference or self link to your subnet, in quotes
  }
}
