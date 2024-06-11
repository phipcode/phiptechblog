variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  default     = "Australia East"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default = "packervm_image"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
}

variable "custom_image_id" {
  description = "The ID of the custom image created by Packer"
  type        = string
}


variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string  
}