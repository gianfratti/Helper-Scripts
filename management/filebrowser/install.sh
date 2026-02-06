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

# Initialize database
print_info "Initializing database..."
filebrowser config init --config /etc/filebrowser/config.json

if [ $? -ne 0 ]; then
    print_error "Failed to initialize File Browser database"
    exit 1
fi

print_info "Configuring File Browser settings..."
filebrowser config set --address 0.0.0.0 --config /etc/filebrowser/config.json
filebrowser config set --port 8080 --config /etc/filebrowser/config.json
filebrowser config set --database /var/lib/filebrowser/filebrowser.db --config /etc/filebrowser/config.json
filebrowser config set --root /srv --config /etc/filebrowser/config.json

# Create admin user with password: admin
print_info "Creating admin user..."

# Remove admin user if exists
filebrowser users rm admin --config /etc/filebrowser/config.json 2>/dev/null || true

# Add admin user with password: admin
if filebrowser users add admin admin --perm.admin --config /etc/filebrowser/config.json; then
    print_success "Admin user created successfully"
else
    print_error "Failed to create admin user"
    exit 1
fi

# Verify admin user was created
print_info "Verifying admin user..."
if filebrowser users ls --config /etc/filebrowser/config.json | grep -q "admin"; then
    print_success "Admin user verified"
else
    print_error "Admin user not found in user list"
    exit 1
fi

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
    print_info "Checking service status..."
    systemctl status filebrowser --no-pager
    exit 1
fi

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
print_success "====================================================="
print_success "  FILE BROWSER INSTALLATION COMPLETED!"
print_success "====================================================="
echo ""
print_success "Access Information:"
print_info "  URL: http://${SERVER_IP}:8080"
print_info "  Username: admin"
print_info "  Password: admin"
echo ""
print_warn "⚠️  IMPORTANT: Change the default password after first login!"
print_warn "   Go to Settings > User Management to change your password"
echo ""
print_info "Additional Information:"
print_info "  File root directory: /srv"
print_info "  Configuration: /etc/filebrowser/config.json"
print_info "  Database: /var/lib/filebrowser/filebrowser.db"
print_info "  Service status: systemctl status filebrowser"
print_info "  View logs: journalctl -u filebrowser -f"
echo ""
print_info "To change password via command line:"
print_info "  sudo filebrowser users update admin --password newpassword --config /etc/filebrowser/config.json"
echo ""

exit 0