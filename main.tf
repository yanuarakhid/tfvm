# Define a map of environment-specific configurations
variable "environments" {
  default = {
    dev = {
      instance_count = 2
      machine_type   = "e2-micro"
      zone           = "asia-southeast1-b"
      # Add other dev environment configurations
    },
    staging = {
      instance_count = 2
      machine_type   = "e2-micro"
      zone           = "asia-southeast1-b"
      # Add other staging environment configurations
    },
    production = {
      instance_count = 2
      machine_type   = "e2-micro"
      zone           = "asia-southeast1-b"
      # Add other production environment configurations
    }
  }
}

# Create instances for each environment using for_each loop with the map
resource "google_compute_instance" "example" {
  for_each = var.environments

  name         = "${each.key}-vm-${count.index + 1}"
  hostname     = "${each.key}-vm-${count.index + 1}"
  machine_type = each.value["machine_type"]
  zone         = each.value["zone"]
  count        = each.value["instance_count"]

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


