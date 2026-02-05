#!/bin/bash
# Webmin Installation Script
# Author: gianfratti
# Description: Installs Webmin web-based system administration tool on Ubuntu/Debian systems

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${BLUE}[SUCCESS]${NC} $1"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    print_error "Please run as root or with sudo"
    exit 1
fi

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION_ID=$VERSION_ID
else
    print_error "Cannot detect OS"
    exit 1
fi

print_info "Detected OS: $OS $VERSION_ID"

# Check if OS is supported
if [[ "$OS" != "ubuntu" && "$OS" != "debian" ]]; then
    print_error "This script only supports Ubuntu and Debian"
    exit 1
fi

print_info "Starting Webmin installation..."
echo ""

# Update package index
print_info "Updating package index..."
apt-get update -y

# Upgrade existing packages
print_info "Upgrading existing packages..."
apt-get upgrade -y

# Install required dependencies
print_info "Installing required dependencies..."
apt-get install -y \
    curl \
    wget \
    gnupg \
    apt-transport-https \
    ca-certificates

# Download Webmin repository setup script
print_info "Downloading Webmin repository setup script..."
curl -o /tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh

if [ ! -f /tmp/setup-repos.sh ]; then
    print_error "Failed to download Webmin repository script"
    exit 1
fi

# Make script executable
chmod +x /tmp/setup-repos.sh

# Run repository setup script
print_info "Setting up Webmin repository..."
echo "y" | bash /tmp/setup-repos.sh

# Update package index with Webmin repository
print_info "Updating package index with Webmin repository..."
apt-get update -y

# Install Webmin with recommended packages
print_info "Installing Webmin..."
apt-get install --install-recommends webmin -y

# Enable Webmin service
print_info "Enabling Webmin service..."
systemctl enable webmin

# Start Webmin service
print_info "Starting Webmin service..."
systemctl start webmin

# Wait for service to start
sleep 3

# Check if Webmin is running
if systemctl is-active --quiet webmin; then
    print_success "Webmin service is running"
else
    print_error "Webmin service failed to start"
    systemctl status webmin
    exit 1
fi

# Get server IP address
SERVER_IP=$(hostname -I | awk '{print $1}')

# Clean up
rm -f /tmp/setup-repos.sh

echo ""
print_success "Webmin installation completed successfully!"
echo ""
print_info "Access Webmin at: https://${SERVER_IP}:10000"
print_info "Default login: root (or your system user)"
print_info "Password: Your system user password"
echo ""
print_warn "Note: The connection uses a self-signed certificate by default"
print_warn "Your browser will show a security warning - this is normal"
echo ""

exit 0