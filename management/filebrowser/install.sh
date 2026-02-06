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
mkdir -p /srv

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
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
print_info "Reloading systemd..."
systemctl daemon-reload

# Enable service
print_info "Enabling File Browser service..."
systemctl enable filebrowser

# Start service and capture initial logs
print_info "Starting File Browser service..."
systemctl start filebrowser

# Wait for service to initialize
sleep 5

# Check if service is running
if systemctl is-active --quiet filebrowser; then
    print_success "File Browser service is running"
else
    print_error "File Browser service failed to start"
    print_info "Checking service status..."
    systemctl status filebrowser --no-pager
    exit 1
fi

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

# Extract auto-generated password from logs
print_info "Extracting admin password from logs..."
AUTO_PASSWORD=$(journalctl -u filebrowser --no-pager -n 100 | grep -oP "password for user 'admin': \K.*" | head -n 1)

echo ""
print_success "====================================================="
print_success "  FILE BROWSER INSTALLATION COMPLETED!"
print_success "====================================================="
echo ""
print_info "Access URL: http://${SERVER_IP}:8080"
echo ""

if [ -n "$AUTO_PASSWORD" ]; then
    print_success "AUTO-GENERATED CREDENTIALS:"
    print_info "  Username: admin"
    print_info "  Password: $AUTO_PASSWORD"
    echo ""
    print_warn "⚠️  SAVE THIS PASSWORD NOW!"
    print_warn "⚠️  This password is only shown once!"
    print_warn "⚠️  Change it after first login in Settings > User Management"
else
    print_warn "Could not extract auto-generated password from logs."
    print_info "To find the password, run:"
    print_info "  sudo journalctl -u filebrowser -n 100 | grep 'password'"
    echo ""
    print_info "Look for a line like:"
    print_info "  'Randomly generated password for user admin: XXXXXXXXXX'"
fi

echo ""
print_info "Additional Information:"
print_info "  File root directory: /srv"
print_info "  Configuration: /etc/filebrowser/config.json"
print_info "  Database: /var/lib/filebrowser/filebrowser.db"
print_info "  Service status: systemctl status filebrowser"
print_info "  View logs: journalctl -u filebrowser -f"
echo ""
print_info "If you need to reset the password:"
print_info "  1. sudo systemctl stop filebrowser"
print_info "  2. sudo rm /var/lib/filebrowser/filebrowser.db"
print_info "  3. sudo systemctl start filebrowser"
print_info "  4. sudo journalctl -u filebrowser -n 50 | grep password"
echo ""

exit 0