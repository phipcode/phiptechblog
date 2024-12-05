# Terraform Proxmox Automation

This project demonstrates how to automate the provisioning of virtual machines (VMs) in Proxmox using Terraform. It leverages Infrastructure as Code (IaC) to simplify VM creation and management, making your workflow more efficient and consistent.

## Features
- Automates VM provisioning in Proxmox
- Configures VMs with Terraform templates
- Supports multiple VM configurations
- Easily scalable for large environments

## Requirements
- Proxmox VE setup
- Terraform installed
- Access to Proxmox API

## Getting Started
1. Clone this repository.
2. Modify the `vms.tfvars` file with your VM specifications.
3. Run `terraform init` to initialize the Terraform environment.
4. Apply the configuration using `terraform apply`.

## Learn More
For a detailed guide and step-by-step instructions, check out my blog post on automating VM provisioning in Proxmox with Terraform:  
[Automate VM Provisioning Using Terraform in Proxmox](phiptech.com/automate-vm-provisioning-using-terraform/)

## License
This project is licensed under the MIT License.
