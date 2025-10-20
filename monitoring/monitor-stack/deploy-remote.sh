#!/bin/bash

# Remote Promtail Deployment Script
# Usage: ./deploy-remote.sh <monitoring_server_ip> <hostname> <server_type>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check arguments
if [ $# -ne 3 ]; then
    print_error "Usage: $0 <monitoring_server_ip> <hostname> <server_type>"
    print_error "Example: $0 192.168.1.100 web-server-01 web"
    exit 1
fi

MONITORING_IP="$1"
HOSTNAME="$2"
SERVER_TYPE="$3"

print_status "Starting Promtail deployment..."
print_status "Monitoring Server: $MONITORING_IP"
print_status "Hostname: $HOSTNAME"
print_status "Server Type: $SERVER_TYPE"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_warning "Docker not found. Installing Docker..."
    sudo apt update
    sudo apt install -y docker.io docker-compose
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
    print_success "Docker installed successfully"
else
    print_success "Docker is already installed"
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    print_warning "Docker Compose not found. Installing..."
    sudo apt install -y docker-compose
fi

# Create promtail-config.yml from template
print_status "Creating Promtail configuration..."
cp promtail-remote-example.yml promtail-config.yml

# Update monitoring server IP
sed -i "s/YOUR_MONITORING_SERVER_IP/$MONITORING_IP/g" promtail-config.yml

# Update hostname in all job configurations
sed -i "s/web-server-01/$HOSTNAME/g" promtail-config.yml

# Update server type
sed -i "s/server_type: \"web\"/server_type: \"$SERVER_TYPE\"/g" promtail-config.yml

print_success "Configuration file created: promtail-config.yml"

# Test connectivity to monitoring server
print_status "Testing connectivity to monitoring server..."
if timeout 5 bash -c "</dev/tcp/$MONITORING_IP/3100"; then
    print_success "Successfully connected to monitoring server"
else
    print_warning "Cannot connect to monitoring server on port 3100"
    print_warning "Please check firewall rules and ensure Loki is running"
fi

# Deploy Promtail
print_status "Deploying Promtail container..."
docker-compose -f docker-compose-remote.yml down 2>/dev/null || true
docker-compose -f docker-compose-remote.yml up -d

# Wait a moment for container to start
sleep 5

# Check container status
if docker-compose -f docker-compose-remote.yml ps | grep -q "Up"; then
    print_success "Promtail container is running"
else
    print_error "Promtail container failed to start"
    print_status "Container logs:"
    docker-compose -f docker-compose-remote.yml logs promtail
    exit 1
fi

# Show container logs
print_status "Recent Promtail logs:"
docker-compose -f docker-compose-remote.yml logs --tail=20 promtail

print_success "Deployment completed successfully!"
print_status "\nNext steps:"
echo "1. Check logs: docker-compose -f docker-compose-remote.yml logs -f promtail"
echo "2. Verify in Grafana with query: {hostname=\"$HOSTNAME\"}"
echo "3. Monitor metrics at: http://localhost:9080/metrics"
echo "\nTo stop: docker-compose -f docker-compose-remote.yml down"
