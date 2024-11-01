# Ubuntu Server Focal
# ---
# Packer Template to create an Ubuntu Server (Focal) on Proxmox


# Variable Definitions
variable "proxmox_api_url" {}
variable "proxmox_api_token_id" {}
variable "proxmox_api_token_secret" {}
variable "node" {}
variable "memory" {}
variable "vm_id" {}
variable "vm_name" {}
variable "template_description" {}
variable "disk_size" {}
variable "cores" {}
variable "ssh_username" {}
variable "ssh_password" {}

# Resource Definition for the VM Template
source "proxmox-iso" "ubuntu-server-focal-template" {

  # Proxmox Connection Settings
  proxmox_url              = var.proxmox_api_url
  username                 = var.proxmox_api_token_id
  token                    = var.proxmox_api_token_secret
  insecure_skip_tls_verify = true

  # VM General Settings
  node                 = var.node
  vm_id                = var.vm_id
  vm_name              = var.vm_name
  template_description = var.template_description

  # VM OS Settings
  # (Option 1) Local ISO File
  iso_file = "local:iso/ubuntu-24.04.1-live-server-amd64.iso"

  # - or -
  # (Option 2) Download ISO
  # iso_url = "https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso"
  # iso_checksum = "f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"

  iso_storage_pool = "local"
  unmount_iso      = true

  # VM System Settings
  qemu_agent = true

  # VM Hard Disk Settings
  scsi_controller = "virtio-scsi-pci"

  disks {
    disk_size         = var.disk_size
    format            = "raw"
    storage_pool      = "local-lvm"            # LVM storage pool name
    storage_pool_type = "lvmthin"            # Set to LVM
    type              = "virtio"
  }

  # VM CPU Settings
  cores = var.cores

  # VM Memory Settings
  memory = var.memory

  # VM Network Settings
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = "false"
  }

  # VM Cloud-Init Settings
  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"          # LVM storage pool name

  # PACKER Boot Commands
  boot_command = [
    "<spacebar><wait><spacebar><wait><spacebar><wait><spacebar><wait><spacebar><wait>",
    "e<wait>",
    "<down><down><down><end>",
    " autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<f10>"
  ]
  boot      = "c"
  boot_wait = "5s"

  # PACKER Autoinstall Settings
  http_directory    = "http"
  http_bind_address = "192.168.0.137"
  http_port_min     = 8802
  http_port_max     = 8802

  # PACKER SSH Settings
  ssh_username = "phip"
  # (Option 1) Add your Password here
  ssh_password = var.ssh_password

  # # (Option 2) Add your Private Key here
  # ssh_private_key_file = "./vm_rsa"

  # Raise the timeout, when installation takes longer
  ssh_timeout            = "30m"
  ssh_handshake_attempts = 1000

}

# Build Definition to create the VM Template
build {

  name    = "ubuntu-server-focal"
  sources = ["source.proxmox-iso.ubuntu-server-focal-template"]

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #1
  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "sudo rm /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo cloud-init clean",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo sync"
    ]
  }

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #2
  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #3
  provisioner "shell" {
    inline = ["sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"]
  }
}