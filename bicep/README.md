# Azure Bicep - Virtual Machine Deployment with Azure Verified Modules

This directory contains Azure Bicep templates that demonstrate how to deploy virtual machines using **Azure Verified Modules (AVM)** for robust, secure, and standardized infrastructure as code.

📖 **Featured Blog Post**: [Deploying Virtual Machines Using Azure Verified Modules with Bicep](https://phiptech.com/deploying-virtual-machines-using-azure-verfied-modules-with-bicep/)

## What is Azure Bicep?

Azure Bicep is a Domain Specific Language (DSL) that uses declarative syntax to deploy Azure resources. It provides:

- **Simplified syntax** compared to ARM templates
- **Type safety** and IntelliSense support
- **Modular design** for reusable infrastructure components
- **Integration with Azure Verified Modules** for enterprise-grade deployments

## What are Azure Verified Modules?

Azure Verified Modules (AVM) are pre-built, Microsoft-verified infrastructure modules that follow best practices for:

- **Security** - Built-in security configurations and compliance
- **Reliability** - Tested and validated deployment patterns
- **Consistency** - Standardized parameter naming and resource configurations
- **Maintainability** - Regular updates and community support

## 📁 Directory Contents

### Core Templates
- **`main.bicep`** - Main deployment template (subscription-scoped)
- **`main.dev.bicepparam`** - Development environment parameters

### Modules
- **`modules/virtualMachine/vm.bicep`** - Custom VM module that leverages AVM

### Key Features
- **Subscription-scoped deployment** for resource group creation
- **Azure Verified Modules integration** for compute and resource management
- **Parameterized configuration** for multiple environments
- **Custom VM module** with flexible networking and storage options

## 🚀 Quick Start

### Prerequisites
- Azure CLI installed and configured
- Bicep CLI extension
- Appropriate Azure subscription permissions

### Deployment Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/phipcode/phiptechblog.git
   cd phiptechblog/bicep
   ```

2. **Review and customize parameters**:
   ```bash
   # Edit the parameter file for your environment
   vim main.dev.bicepparam
   ```

3. **Deploy the infrastructure**:
   ```bash
   # Create deployment at subscription scope
   az deployment sub create \
     --location australiaeast \
     --template-file main.bicep \
     --parameters main.dev.bicepparam
   ```

### Example Configuration

The template supports flexible VM configurations:

```bicep
virtualMachines = [
  {
    name: 'vm-dev-01'
    location: 'australiaeast'
    adminUsername: 'azureuser'
    subnetId: '/subscriptions/.../subnets/privateEndpoints'
    vmSize: 'Standard_D4s_v3'
    imageReference: {
      offer: 'WindowsServer'
      publisher: 'MicrosoftWindowsServer'
      sku: '2022-datacenter-azure-edition'
      version: 'latest'
    }
  }
]
```

## 🛠️ Architecture

This solution demonstrates:

1. **Resource Group Creation** using AVM resource group module
2. **Virtual Machine Deployment** using AVM compute module
3. **Network Configuration** with existing subnet integration
4. **Storage Management** with managed disk configurations
5. **Security Best Practices** through AVM built-in protections

## 📚 Learn More

For a detailed walkthrough, deployment examples, and best practices, check out the comprehensive blog post:

**🔗 [Deploying Virtual Machines Using Azure Verified Modules with Bicep](https://phiptech.com/deploying-virtual-machines-using-azure-verfied-modules-with-bicep/)**

The blog post covers:
- Setting up Azure Bicep development environment
- Understanding Azure Verified Modules
- Step-by-step deployment walkthrough
- Troubleshooting common issues
- Advanced configuration scenarios

## 🔧 Customization

### Adding New VMs
Extend the `virtualMachines` array in your parameter file with additional VM configurations.

### Network Integration
Update the `subnetId` parameter to point to your existing virtual network subnet.

### Storage Options
Modify the `osDisk` configuration to adjust disk size, type, and caching options.

## ⚠️ Important Notes

- **Credentials**: Never commit passwords or secrets to version control
- **Resource Naming**: Adjust naming conventions to match your organization's standards
- **Regions**: Ensure all resources are deployed to compliant regions
- **Cost Management**: Monitor resource usage and implement appropriate governance

## 📄 License

This project is licensed under the MIT License - see the main repository LICENSE file for details.