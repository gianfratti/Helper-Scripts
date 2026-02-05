#!/bin/bash
# File Browser Installation Script
# Author: gianfratti
# Description: Installs File Browser web-based file manager on Ubuntu/Debian systems

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

print_info "Starting File Browser installation..."
echo ""

# Install dependencies
print_info "Installing dependencies..."
apt-get update -y
apt-get install -y curl wget

# Download and install File Browser
print_info "Downloading File Browser..."
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

if [ $? -ne 0 ]; then
    print_error "Failed to download/install File Browser"
    exit 1
fi

# Verify installation
if command -v filebrowser &> /dev/null; then
    FB_VERSION=$(filebrowser version | head -n 1)
    print_success "File Browser installed: $FB_VERSION"
else
    print_error "File Browser installation failed"
    exit 1
fi

# Create directory structure
print_info "Creating directory structure..."
mkdir -p /etc/filebrowser
mkdir -p /var/lib/filebrowser

# Create default configuration
print_info "Creating default configuration..."
cat > /etc/filebrowser/config.json <<EOF
{
  "port": 8080,
  "baseURL": "",
  "address": "0.0.0.0",
  "log": "stdout",
  "database": "/var/lib/filebrowser/filebrowser.db",
  "root": "/srv"
}
EOF

# Initialize database
print_info "Initializing database..."
filebrowser config init --config /etc/filebrowser/config.json
filebrowser config set --address 0.0.0.0 --port 8080 --database /var/lib/filebrowser/filebrowser.db --root /srv --config /etc/filebrowser/config.json

# Create admin user
print_info "Creating default admin user..."
filebrowser users add admin admin --perm.admin --config /etc/filebrowser/config.json 2>/dev/null || true

# Create systemd service
print_info "Creating systemd service..."
cat > /etc/systemd/system/filebrowser.service <<EOF
[Unit]
Description=File Browser
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/filebrowser -c /etc/filebrowser/config.json
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
print_info "Reloading systemd..."
systemctl daemon-reload

# Enable and start service
print_info "Enabling File Browser service..."
systemctl enable filebrowser

print_info "Starting File Browser service..."
systemctl start filebrowser

# Wait for service to start
sleep 3

# Check if service is running
if systemctl is-active --quiet filebrowser; then
    print_success "File Browser service is running"
else
    print_error "File Browser service failed to start"
    systemctl status filebrowser
    exit 1
fi

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
print_success "File Browser installation completed successfully!"
echo ""
print_info "Access File Browser at: http://${SERVER_IP}:8080"
print_info "Default credentials:"
print_info "  Username: admin"
print_info "  Password: admin"
echo ""
print_warn "IMPORTANT: Change the default password after first login!"
print_warn "Go to Settings > User Management to change your password"
echo ""
print_info "File root directory: /srv"
print_info "Configuration file: /etc/filebrowser/config.json"
print_info "Database file: /var/lib/filebrowser/filebrowser.db"
echo ""

exit 0