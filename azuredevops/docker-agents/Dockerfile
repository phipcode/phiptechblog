FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    curl \
    wget \
    sudo \
    jq \
    unzip \
    git \
    libcurl4 \
    libunwind8 \
    gettext \
    apt-transport-https \
    ca-certificates \
    gnupg \
    software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
  
# Install PowerShell
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-jammy-prod jammy main" > /etc/apt/sources.list.d/microsoft.list' && \
    apt-get update && \
    apt-get install -y powershell && \
    rm microsoft.gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/3.6.4/pandoc-3.6.4-1-amd64.deb -O /tmp/pandoc.deb && \
    apt install -y /tmp/pandoc.deb && \
    rm /tmp/pandoc.deb

# Install Bicep CLI
RUN curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64 \
  && chmod +x ./bicep \
  && mv ./bicep /usr/local/bin/bicep

# Install Azure CLI
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m azdo

# Copy script and fix permissions
WORKDIR /home/azdo
COPY start.sh ./start.sh
RUN chmod +x ./start.sh && chown azdo:azdo ./start.sh

# Grant azdo user passwordless sudo access
RUN echo "azdo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to azdo user
USER azdo


# Download the agent
ARG AZP_AGENT_PACKAGE_URL=https://vstsagentpackage.azureedge.net/agent/4.255.0/vsts-agent-linux-x64-4.255.0.tar.gz
RUN curl -LsS $AZP_AGENT_PACKAGE_URL | tar -xz

ENTRYPOINT ["./start.sh"]