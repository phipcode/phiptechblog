packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}
variable "resource_group" {}
variable "image_name" {}
variable "location" {}


locals {
  virtual_network_name                = "syd-prd-net-vnetphip-001"
  virtual_network_subnet_name         = "syd-prd-net-subnetappphip-001"
  virtual_network_resource_group_name = "syd-prd-netrgphip-001"
  resource_group_name                 = "syd-prd-apprgphip-001"
}

source "azure-arm" "example" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  # build_resource_group_name         = local.resource_group_name
  managed_image_resource_group_name = local.resource_group_name
  managed_image_name                = var.image_name
  os_type                           = "Windows"
  image_publisher                   = "MicrosoftWindowsServer"
  image_offer                       = "WindowsServer"
  image_sku                         = "2022-datacenter-azure-edition"
  location                          = var.location
  vm_size                           = "Standard_DS2_v2"
  communicator                      = "winrm"
  winrm_username                    = "Packer_admin!2"
  winrm_password                    = "p@cker551^%22"
  winrm_timeout                     = "2h"
  winrm_insecure                    = true
  winrm_use_ssl                     = true

  # virtual_network_name                = local.virtual_network_name
  # virtual_network_subnet_name         = local.virtual_network_subnet_name
  # virtual_network_resource_group_name = local.virtual_network_resource_group_name
}

build {
  sources = ["source.azure-arm.example"]

  provisioner "powershell" {
    inline = [
      "# If Guest Agent services are installed, make sure that they have started.",
      "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }
}