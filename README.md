<div align="center">

# Phi's Tech Blog — Infrastructure & DevOps Code Examples

[![Terraform](https://img.shields.io/badge/Terraform-1.x-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-DevOps-0078D4?logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Proxmox](https://img.shields.io/badge/Proxmox-VE-E57000?logo=proxmox&logoColor=white)](https://www.proxmox.com/)
[![License](https://img.shields.io/badge/License-MIT-22c55e)](LICENSE)

> 🌐 **Live blog:** [phiptech.com](https://phiptech.com) — Infrastructure, DevOps, HomeLab & Cloud tutorials

</div>

---

Welcome to the companion code repository for **[Phi's Tech Blog](https://phiptech.com)**. Every folder maps to a real blog post with step-by-step instructions. Clone it, pick a directory, and follow along.

## 📁 Repository Structure

| Directory | What's inside | Related post |
|---|---|---|
| [`azuredevops/docker-agents`](./azuredevops/docker-agents) | Self-hosted Azure DevOps build agents in Docker containers | [Deploying Multiple Self-Hosted DevOps Agents Using Docker](https://phiptech.com/how-to-run-multiple-azure-devops-self-hosted-agents-using-docker-and-a-dockerfile/) |
| [`bicep/`](./bicep) | Azure-native IaC templates using Bicep & Azure Verified Modules | [Deploying VMs with Azure Verified Modules & Bicep](https://phiptech.com/deploying-virtual-machines-using-azure-verfied-modules-with-bicep/) |
| [`cloudflaretunnel/`](./cloudflaretunnel) | Expose local services securely via Cloudflare Tunnel + Docker | — |
| [`monitoring/`](./monitoring) | Prometheus + Grafana + Loki + Promtail observability stack | [Real-Time Log Monitoring with Grafana, Loki & Promtail](https://phiptech.com/real-time-monitoring-with-grafana-loki-and-promtail-a-complete-guide/) |
| [`packer/`](./packer) | Azure & Proxmox image builds (Windows Server 2022, Ubuntu cloud-init) | — |
| [`terraform/proxmox/vm_build`](./terraform/proxmox/vm_build) | Automated Proxmox VM provisioning with Terraform | — |

## 🛠️ Tech Stack

<table>
<tr>
<td><strong>Infrastructure as Code</strong></td>
<td>Terraform · Packer · Azure Bicep</td>
</tr>
<tr>
<td><strong>Cloud Platforms</strong></td>
<td>Microsoft Azure · Proxmox VE · Cloudflare</td>
</tr>
<tr>
<td><strong>DevOps & CI/CD</strong></td>
<td>Azure DevOps · GitHub Actions · Docker</td>
</tr>
<tr>
<td><strong>Monitoring</strong></td>
<td>Prometheus · Grafana · Loki · Promtail</td>
</tr>
</table>

## ⚡ Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/phipcode/phiptechblog.git
cd phiptechblog

# 2. Navigate to the example you want
cd monitoring/              # Prometheus + Grafana stack
cd azuredevops/docker-agents
cd cloudflaretunnel/
cd packer/
cd terraform/proxmox/vm_build
cd bicep/

# 3. Read the directory's README and follow along
```

Each directory has its own `README.md` with detailed setup instructions.

## 📋 Prerequisites

Make sure you have the relevant tools installed before running any example:

| Tool | Version | Required for |
|---|---|---|
| Git | any | All examples |
| Docker + Docker Compose | latest | `azuredevops/`, `cloudflaretunnel/`, `monitoring/` |
| Terraform | ≥ 1.0 | `terraform/` |
| Packer | ≥ 1.7 | `packer/` |
| Azure CLI | latest | `bicep/`, `azuredevops/` |

**Account requirements:**
- Azure subscription — for Azure-related examples
- Proxmox VE server — for virtualization examples
- Cloudflare account — for tunnel examples

## 📰 Latest Blog Posts
<!-- BLOG-CARDS:START -->
<!-- BLOG-CARDS:END -->

## ⚠️ Before You Deploy

- **Never commit secrets** — use environment variables or a secrets manager (Azure Key Vault, HashiCorp Vault)
- **Test in dev first** — always validate in a non-production environment before applying to prod
- **Review defaults** — change all default passwords, IP ranges, and resource names to match your environment
- **Check versions** — Terraform provider and Packer plugin versions may need pinning; see each directory's README

## 🤝 Contributing

Contributions are welcome. To contribute:

1. Fork the repo and create a feature branch
2. Test your changes in a development environment
3. Update the relevant `README.md` if anything changes
4. Open a pull request with a clear description

Useful contribution types: bug fixes, new IaC examples, documentation improvements, version updates.

## 📫 Connect

- **Blog:** [phiptech.com](https://phiptech.com)
- **GitHub:** [@phipcode](https://github.com/phipcode)
- **LinkedIn:** [Phi Pham](https://www.linkedin.com/in/phi-pham-4070b397/)
- **Email:** contact@phiptech.com

## 📄 License

MIT — see individual directories for any additional licensing requirements.

---

<div align="center">
⭐ If these examples saved you time, a star on the repo goes a long way!
</div>
