# Setup terraform and providers
terraform {
  required_version = ">=0.14"

  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}

# Configure provider
provider "hcloud" {
  token = "chFbLbq6TLacKT5jcVgrbYDhBLAJjqX3tsHZqGpsuP8ncrwCULfL8Brp3chhsEFa"
}

# The centralised network
data "hcloud_network" "network" {
  name = "iac-training"
}

### Adjust below here ###

locals {
  # Your team ID
  team-id = ...
}

# Your SSH key
resource "hcloud_ssh_key" "team-key" {
  name       = "Team ${local.team-id}"
  ...
}

data "hcloud_image" "ubuntu" {
  ...
}

# Your Server
# View with: terraform state show hcloud_server.server
resource "hcloud_server" "server" {
  name        = "team-${local.team-id}"
  server_type = "cx11"

  ...
}

# Server to network connection
resource "hcloud_server_network" "network" {
  ip = "10.13.37.${local.team-id + 100}"
  ...
}

# Volume
resource "hcloud_volume" "data" {
  name      = "team-${local.team-id}"
  size      = 10

  # Don't delete data
  lifecycle {
    prevent_destroy = true
  }

  ...
}

# Attach volume
resource "hcloud_volume_attachment" "data" {
  ...
}