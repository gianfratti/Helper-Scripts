#!/bin/bash
# File Browser Uninstallation Script
# Author: gianfratti
# Description: Uninstalls File Browser from Ubuntu/Debian systems

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

print_info "Starting File Browser uninstallation..."
echo ""

# Check if File Browser is installed
if ! command -v filebrowser &> /dev/null; then
    print_warn "File Browser is not installed on this system."
    exit 0
fi

# Stop File Browser service
print_info "Stopping File Browser service..."
if systemctl is-active --quiet filebrowser; then
    systemctl stop filebrowser
    print_success "File Browser service stopped"
else
    print_warn "File Browser service was not running"
fi

# Disable File Browser service
print_info "Disabling File Browser service..."
if systemctl is-enabled --quiet filebrowser 2>/dev/null; then
    systemctl disable filebrowser
    print_success "File Browser service disabled"
fi

# Remove systemd service file
print_info "Removing systemd service file..."
if [ -f /etc/systemd/system/filebrowser.service ]; then
    rm -f /etc/systemd/system/filebrowser.service
    systemctl daemon-reload
    print_success "Systemd service file removed"
fi

# Remove File Browser binary
print_info "Removing File Browser binary..."
if [ -f /usr/local/bin/filebrowser ]; then
    rm -f /usr/local/bin/filebrowser
    print_success "File Browser binary removed"
fi

# Remove configuration and data
print_info "Removing configuration and database files..."
if [ -d /etc/filebrowser ]; then
    rm -rf /etc/filebrowser
    print_success "Configuration directory removed"
fi

if [ -d /var/lib/filebrowser ]; then
    rm -rf /var/lib/filebrowser
    print_success "Database directory removed"
fi

echo ""
print_success "File Browser has been successfully uninstalled!"
echo ""
print_info "If you want to reinstall File Browser later, run:"
echo "   curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/filebrowser/install.sh | sudo bash"
echo ""

exit 0