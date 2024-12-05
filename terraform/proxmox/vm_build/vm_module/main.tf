
locals {
  vm_name_to_index = { for i, vm in var.vms : vm.name => i }
}

# Modify path for templatefile and use the recommended extension of .tftpl for syntax hylighting in code editors.
resource "local_file" "cloud_init_user_data_file" {
  for_each = { for vm in var.vms : vm.name => vm }

  content  = templatefile("${path.module}/../cloud-inits/cloud-init.cloud_config.tpl", { hostname = each.value.vm_name })
  filename = "${path.module}/files/user_data_${each.key}.cfg"
}

resource "null_resource" "cloud_init_config_files" {
  for_each = local_file.cloud_init_user_data_file
  connection {
    type     = "ssh"
    user     = var.ssh_user
    password = var.ssh_password
    host     = var.ssh_host
    timeout  = "30s"
  }

  provisioner "file" {
    source      = each.value.filename
    destination = "/var/lib/vz/snippets/user_data_${each.key}.yml"
  }
}



resource "proxmox_vm_qemu" "ubuntu-server" {
  for_each = var.vms
  name        = each.value.name
  desc        = "Ubuntu Server"
  vmid        = each.value.vm_id
  target_node = each.value.target_node

  #Path to the user-data file
  cicustom = "user=local:snippets/user_data_${each.key}.yml"

  agent = 1

  # The template name to clone this vm from
  clone      = each.value.clone
  full_clone = true

  onboot           = true
  automatic_reboot = false

  os_type = "cloud-init"

  cores     = each.value.vm_cores
  sockets   = 1
  cpu       = "x86-64-v2-AES"
  memory    = each.value.vm_memory
  ipconfig0 = "ip=dhcp"

  network {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = -1
  }

  # Conditionally include `hostpci` if `pci_device` is specified
  dynamic "hostpci" {
    for_each = (each.value.pci_device != null && each.value.pci_device != "") ? [each.value.pci_device] : []
    content {
      pcie   = 1
      rombar = 0
      host   = hostpci.value
    }
  }

  scsihw = "virtio-scsi-pci"

  disks {
    virtio {
      virtio0 {
        disk {
          format  = "raw"
          size    = each.value.disk_size
          storage = each.value.storage
        }
      }
    }
    /* Create the Cloud-Init drive on the "local-lvm" storage */
    ide {
      ide3 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
  

  # Setup the ip address using cloud-init.
  boot = "order=virtio0"

  # Keep in mind to use the CIDR notation for the ip.
  # ipconfig0 = "ip=192.168.0.223/24,gw=192.168.0.1"


  lifecycle {
    ignore_changes = [
      vm_state,
      disks,
      hostpci,  # Ensure hostpci is included here
    ]
  }
}


# (Optional) IP Address and Gateway
# ipconfig0 = "ip=0.0.0.0/0,gw=0.0.0.0"

# (Optional) Default User
# ciuser = "your-username"

# (Optional) Add your SSH KEY
# sshkeys = <<EOF
# #YOUR-PUBLIC-SSH-KEY
# EOF
