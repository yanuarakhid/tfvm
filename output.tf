# Output the created instances' names
output "vm_dev" {
  value = [for instance in google_compute_instance.dev : instance.name]
}

# Output the created instances' names
output "vm_staging" {
  value = [for instance in google_compute_instance.staging : instance.name]
}

# Output the created instances' names
output "vm_prod" {
  value = [for instance in google_compute_instance.production : instance.name]
}

