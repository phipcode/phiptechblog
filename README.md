# Phi's Tech Blog - Infrastructure & DevOps Code Examples

Welcome to the code repository for **Phi's Tech Blog**! This repository contains practical, real-world examples of Infrastructure as Code (IaC), DevOps automation, and cloud technologies that I've shared through blog posts and tutorials.

## 🎯 Repository Purpose

This collection serves as a learning resource for developers, system administrators, and DevOps engineers looking to:
- **Learn Infrastructure as Code** with hands-on examples
- **Automate cloud deployments** using modern DevOps tools
- **Build robust monitoring solutions** for production environments
- **Implement secure networking** with tunneling and proxy solutions
- **Follow best practices** for cloud infrastructure management

## 🛠️ Technologies & Tools

This repository covers a comprehensive stack of modern DevOps and cloud technologies:

### **Infrastructure as Code**
- **Terraform** - Infrastructure provisioning and management
- **Packer** - Custom image building for cloud platforms
- **Azure Bicep** - Azure-native infrastructure templates

### **Cloud Platforms & Services**
- **Microsoft Azure** - Cloud services and virtual machines
- **Proxmox VE** - Virtualization platform
- **Cloudflare** - CDN, DNS, and tunnel services

### **DevOps & Automation**
- **Azure DevOps** - CI/CD pipelines and build agents
- **Docker** - Containerization and orchestration
- **Prometheus & Grafana** - Monitoring and observability

## 📋 Prerequisites

Before using the examples in this repository, ensure you have:

### **Required Software**
```bash
# Essential tools (choose based on your examples)
- Git
- Docker & Docker Compose
- Terraform (>= 1.0)
- Packer (>= 1.7)
- Azure CLI (for Azure examples)
```

### **Account Requirements**
- **Azure Subscription** (for Azure-related examples)
- **Proxmox VE Server** (for virtualization examples)
- **Cloudflare Account** (for tunnel examples)
- **GitHub Account** (for Azure DevOps integration)

### **Network & Access**
- **Administrative access** to your target infrastructure
- **Network connectivity** to cloud providers
- **API tokens/credentials** for your cloud services

## 🚀 Getting Started

### 1. **Clone the Repository**
```bash
git clone https://github.com/phipcode/phiptechblog.git
cd phiptechblog
```

### 2. **Choose Your Starting Point**
Navigate to the directory that matches your use case:

```bash
# For Azure DevOps automation
cd azuredevops/docker-agents

# For infrastructure monitoring
cd monitoring/prometheus-grafana

# For secure tunneling
cd cloudflaretunnel

# For custom image building
cd packer

# For infrastructure provisioning
cd terraform/proxmox/vm_build

# For Azure Bicep templates
cd bicep
```

### 3. **Follow Directory-Specific Instructions**
Each directory contains its own README with detailed setup instructions and usage examples.

## 📁 Repository Structure

### **[Azure DevOps](./azuredevops/)**
- **Docker Agents** - Self-hosted Azure DevOps build agents in containers
- Learn how to scale your CI/CD pipeline with containerized agents

### **[Azure Bicep](./bicep/)**
- **Infrastructure Templates** - Azure-native IaC using Bicep
- Modular templates for common Azure infrastructure patterns

### **[Cloudflare Tunnel](./cloudflaretunnel/)**
- **Secure Tunneling** - Expose local services safely through Cloudflare
- Docker-based setup for easy deployment and management

### **[Monitoring](./monitoring/)**
- **Prometheus & Grafana Stack** - Complete monitoring solution
- Production-ready configuration for infrastructure observability

### **[Packer](./packer/)**
- **Azure Templates** - Custom Windows Server 2022 images
- **Proxmox Templates** - Ubuntu Server images with cloud-init
- Automated image building for consistent deployments

### **[Terraform](./terraform/)**
- **Proxmox VM Automation** - Automated virtual machine provisioning
- Scalable infrastructure management with Infrastructure as Code

### **📰 Latest Blog Posts**

<!-- BLOG-POST-LIST:START -->
- [Installing Grafana &amp; Prometheus for Proxmox Monitoring](https://phiptech.com/installing-grafana-prometheus-for-proxmox-monitoring/)
- [Deploying virtual machines  using Azure Verified Modules with Bicep](https://phiptech.com/deploying-virtual-machines-using-azure-verfied-modules-with-bicep/)
- [How to Set Up Local HTTPS with Custom Certificates Using Nginx Proxy Manager](https://phiptech.com/how-to-set-up-https-locally-using-nginx-proxy-manager/)
- [Deploying Multiple Self-Hosted DevOps Agents Using Docker](https://phiptech.com/how-to-run-multiple-azure-devops-self-hosted-agents-using-docker-and-a-dockerfile/)
- [How to Install Oh My Posh on Windows &lpar;PowerShell 7 + winget&rpar;](https://phiptech.com/how-to-install-oh-my-posh-on-windows-powershell-7-winget/)
<!-- BLOG-POST-LIST:END -->

## ⚠️ Important Notes & Caveats

### **Security Considerations**
- **Never commit secrets** - Use environment variables or secure vaults
- **Review default passwords** - Change all default credentials before deployment
- **Network security** - Ensure proper firewall rules and access controls
- **API tokens** - Use least-privilege access and rotate tokens regularly

### **Customization Required**
- **Infrastructure sizing** - Adjust VM specs, storage, and networking for your environment
- **Network configuration** - Update IP ranges, VLANs, and DNS settings
- **Resource naming** - Modify naming conventions to match your organization
- **Cloud regions** - Select appropriate regions for compliance and performance

### **Testing & Validation**
- **Test in development** - Always test configurations in non-production environments
- **Backup before changes** - Create backups before modifying existing infrastructure
- **Monitor resource usage** - Keep track of cloud costs and resource consumption

### **Version Compatibility**
- **Tool versions** - Check compatibility between Terraform, Packer, and provider versions
- **API changes** - Cloud provider APIs may change; update configurations as needed
- **Dependencies** - Some examples may require specific versions of dependencies

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. **Fork the repository** and create a feature branch
2. **Test your changes** thoroughly in a development environment
3. **Update documentation** for any new features or changes
4. **Follow existing code style** and naming conventions
5. **Submit a pull request** with a clear description of changes

### **Types of Contributions**
- 🐛 **Bug fixes** - Fix issues in existing code
- ✨ **New examples** - Add new infrastructure patterns or tools
- 📝 **Documentation** - Improve README files and code comments
- 🔧 **Updates** - Keep dependencies and versions current

## 📫 Connect with Me

- **Email**: [contact@phiptech.com](mailto:contact@phiptech.com)
- **Blog**: [https://phiptech.com](https://phiptech.com)
- **GitHub**: [@phipcode](https://github.com/phipcode)

## 📄 License

This project is licensed under the **MIT License**. See individual directories for any specific licensing requirements.

---

**⭐ If you find these examples helpful, please star the repository and share it with others!**
