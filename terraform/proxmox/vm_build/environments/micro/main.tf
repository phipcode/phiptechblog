# Module block to reference the vm_module
module "vm_build" {
  source = "../../vm_module"

  # Pass in variables from the tfvars
  vms          = var.vms
  ssh_user     = var.ssh_user
  ssh_password = var.ssh_password
  ssh_host     = var.ssh_host
}

