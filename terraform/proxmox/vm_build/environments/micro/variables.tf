
variable "environment" {
  type    = string
  default = "dev"
}

variable "project" {
  type    = string
  default = "docker"
}

variable "role" {
  type    = string
  default = "ubuntu-server"
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
}




variable "vm_count" {
  description = "Number of VMs to create"
  default     = 1
}

variable "vm_cores" {
  description = "Number of cores per VM"
  default     = 4
}

variable "vm_memory" {
  description = "Amount of memory per VM (in MB)"
  default     = 4096
}

variable "disk_size" {
  description = "Size of the disk for each VM (in GB)"
  default     = 50
}


variable "ssh_user" {
  description = "SSH user for VM access"
  type        = string
}

variable "ssh_password" {
  description = "SSH password for VM access"
  type        = string
  sensitive   = true
}

variable "ssh_host" {
  description = "SSH host for VM access"
  type        = string
}

variable "vms" {
  description = "A map of VMs to create"
  type = map(object({
    clone      = string
    vm_name    = string
    name       = string
    vm_cores   = number
    vm_memory  = number
    disk_size  = string
    vm_id      = number
    target_node =  string
    storage = string
  }))
}