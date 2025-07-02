# Azure DevOps Self-Hosted Docker Agents

This directory contains everything you need to run **multiple Azure DevOps self-hosted agents** using Docker containers. These containerized agents provide a scalable, consistent, and isolated environment for your CI/CD pipelines.

📖 **Blog Post**: [How to Run Multiple Azure DevOps Self-Hosted Agents Using Docker and a Dockerfile](https://phiptech.com/how-to-run-multiple-azure-devops-self-hosted-agents-using-docker-and-a-dockerfile/)

## What's Included

This setup provides a comprehensive Azure DevOps build agent with the following tools pre-installed:

### **Core Development Tools**
- **Git** - Version control
- **PowerShell** - Cross-platform automation
- **Azure CLI** - Azure cloud management
- **Bicep CLI** - Azure infrastructure as code
- **Pandoc** - Document conversion utility

### **Container Features**
- **Ubuntu 24.04** base image
- **Non-root user** (`azdo`) for security
- **Passwordless sudo** access for the build user
- **Auto-cleanup** on container termination
- **Configurable agent naming** and pool assignment

## Prerequisites

Before using these Docker agents, ensure you have:

1. **Docker installed** on your host system
2. **Azure DevOps organization** with appropriate permissions
3. **Personal Access Token (PAT)** with agent pool management permissions
4. **Agent pool** created in your Azure DevOps organization

### Creating a Personal Access Token

1. Go to Azure DevOps → User Settings → Personal Access Tokens
2. Create a new token with **Agent Pools (read, manage)** permissions
3. Copy the token for use in environment configuration

## Quick Start

### 1. **Clone the Repository**
```bash
git clone https://github.com/phipcode/phiptechblog.git
cd phiptechblog/azuredevops/docker-agents
```

### 2. **Configure Environment Variables**
Copy the template and configure your settings:
```bash
cp .env.template .env1
```

Edit `.env1` with your Azure DevOps details:
```bash
AZP_URL=https://dev.azure.com/your-organization
AZP_TOKEN=your-personal-access-token
AZP_POOL=your-agent-pool-name
AZP_AGENT_NAME=docker-agent-1
```

### 3. **Build the Docker Image**
```bash
docker build -t azure-devops-agent .
```

### 4. **Run a Single Agent**
```bash
docker run -d \
  --env-file .env1 \
  --name azure-agent-1 \
  azure-devops-agent
```

### 5. **Run Multiple Agents**
For multiple agents, create additional environment files:
```bash
# Create configurations for multiple agents
cp .env.template .env2
cp .env.template .env3
cp .env.template .env4

# Edit each file with unique AZP_AGENT_NAME values
# Then run multiple containers:
docker run -d --env-file .env1 --name azure-agent-1 azure-devops-agent
docker run -d --env-file .env2 --name azure-agent-2 azure-devops-agent
docker run -d --env-file .env3 --name azure-agent-3 azure-devops-agent
docker run -d --env-file .env4 --name azure-agent-4 azure-devops-agent
```

## Configuration Options

### **Environment Variables**

| Variable | Description | Example |
|----------|-------------|---------|
| `AZP_URL` | Your Azure DevOps organization URL | `https://dev.azure.com/myorg` |
| `AZP_TOKEN` | Personal Access Token | `your-pat-token` |
| `AZP_POOL` | Agent pool name | `Default` |
| `AZP_AGENT_NAME` | Unique agent name | `docker-agent-1` |

### **Docker Build Arguments**

You can customize the agent version during build:
```bash
docker build \
  --build-arg AZP_AGENT_PACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/4.255.0/vsts-agent-linux-x64-4.255.0.tar.gz \
  -t azure-devops-agent .
```

## Management Commands

### **View Agent Status**
```bash
# Check running containers
docker ps

# View agent logs
docker logs azure-agent-1

# Follow real-time logs
docker logs -f azure-agent-1
```

### **Stop Agents**
```bash
# Stop a specific agent
docker stop azure-agent-1

# Stop all agents
docker stop $(docker ps -q --filter ancestor=azure-devops-agent)
```

### **Remove Agents**
```bash
# Remove a specific agent
docker rm azure-agent-1

# Remove all stopped containers
docker container prune
```

## How It Works

1. **Container Startup**: The `start.sh` script runs on container startup
2. **Agent Configuration**: Downloads and configures the Azure DevOps agent
3. **Registration**: Registers with your Azure DevOps organization
4. **Job Execution**: Waits for and executes pipeline jobs
5. **Cleanup**: Automatically removes agent registration on container termination

## Directory Structure

```
azuredevops/docker-agents/
├── Dockerfile          # Multi-tool agent image definition
├── start.sh            # Agent startup and configuration script
├── docker-compose.yml  # Docker Compose configuration (optional)
├── .env.template       # Environment variable template
├── .env1               # Agent 1 configuration
├── .env2               # Agent 2 configuration
├── .env3               # Agent 3 configuration
├── .env4               # Agent 4 configuration
└── README.md           # This documentation
```

## Troubleshooting

### **Agent Registration Issues**
- Verify your PAT has **Agent Pools (read, manage)** permissions
- Check that the agent pool exists in your Azure DevOps organization
- Ensure the `AZP_URL` format is correct

### **Container Startup Issues**
- Check environment variables are properly set
- Verify Docker has sufficient resources allocated
- Review container logs for specific error messages

### **Network Connectivity**
- Ensure Docker containers can reach `dev.azure.com`
- Check firewall rules if running behind corporate proxy
- Verify DNS resolution from within containers

## Advanced Usage

For detailed instructions on scaling, production deployment, and advanced configuration options, see the comprehensive blog post:

🔗 **[How to Run Multiple Azure DevOps Self-Hosted Agents Using Docker and a Dockerfile](https://phiptech.com/how-to-run-multiple-azure-devops-self-hosted-agents-using-docker-and-a-dockerfile/)**

## Contributing

Found an issue or want to improve the setup? Please submit an issue or pull request in the main repository.

## License

This project is part of Phi's Tech Blog code examples and follows the repository's licensing terms.