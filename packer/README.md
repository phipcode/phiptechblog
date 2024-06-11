# Azure Packer Template

This Packer template is used to create a Windows Server 2022 image on Azure. 

## Variables

The template uses the following variables, which you need to provide:

- `client_id`: The Azure service principal id.
- `client_secret`: The Azure service principal secret.
- `tenant_id`: The Azure tenant id.
- `subscription_id`: The Azure subscription id.
- `resource_group`: The Azure resource group where the image will be created.
- `image_name`: The name of the image to be created.
- `location`: The Azure region where the image will be created.

## Local Variables

The template also defines some local variables for the virtual network and resource group names. These are currently hardcoded and you may need to adjust them according to your infrastructure.

```hcl
locals {
  virtual_network_name                = "syd-prd-net-vnetphip-001"
  virtual_network_subnet_name         = "syd-prd-net-subnetappphip-001"
  virtual_network_resource_group_name = "syd-prd-cldfoud-netrgphip-001"
  resource_group_name                 = "syd-prd-cldfoud-apprgphip-001"
}

The template uses the azure-arm Packer source. It is configured to create a Windows Server 2022 image in the specified resource group and location. The VM size is set to Standard_DS2_v2.
source "azure-arm" "example" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

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
}

The template uses a powershell provisioner to prepare the Windows image. This includes starting necessary services and running the Sysprep tool to generalize the image.

provisioner "powershell" {
  inline = [
    "# If Guest Agent services are installed, make sure that they have started.",
    "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",
    "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
    "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
  ]
}
Security Note: The winrm_username and winrm_password are hardcoded in this template. For enhanced security, consider implementing a more secure method of handling these credentials.
