# Proxmox Provider
# ---
# Initial Provider Configuration for Proxmox

terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}
