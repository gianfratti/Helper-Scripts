#!/bin/bash
# Webmin Uninstallation Script
# Author: gianfratti
# Description: Uninstalls Webmin from Ubuntu/Debian systems

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

print_warn "This will completely remove Webmin from your system."
echo ""
read -p "Are you sure you want to continue? (yes/no): " -r
echo ""

if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    print_info "Uninstallation cancelled."
    exit 0
fi

print_info "Starting Webmin uninstallation..."
echo ""

# Check if Webmin is installed
if ! command -v webmin &> /dev/null; then
    print_warn "Webmin is not installed on this system."
    exit 0
fi

# Stop Webmin service
print_info "Stopping Webmin service..."
if systemctl is-active --quiet webmin; then
    systemctl stop webmin
    print_success "Webmin service stopped"
else
    print_warn "Webmin service was not running"
fi

# Disable Webmin service
print_info "Disabling Webmin service..."
if systemctl is-enabled --quiet webmin 2>/dev/null; then
    systemctl disable webmin
    print_success "Webmin service disabled"
fi

# Uninstall Webmin package
print_info "Removing Webmin package..."
apt-get remove --purge webmin -y

if [ $? -eq 0 ]; then
    print_success "Webmin package removed"
else
    print_error "Failed to remove Webmin package"
    exit 1
fi

# Remove Webmin repository
print_info "Removing Webmin repository..."
if [ -f /etc/apt/sources.list.d/webmin.list ]; then
    rm -f /etc/apt/sources.list.d/webmin.list
    print_success "Webmin repository removed"
else
    print_warn "Webmin repository file not found"
fi

# Remove Webmin GPG key
print_info "Removing Webmin GPG key..."
if [ -f /usr/share/keyrings/webmin.gpg ]; then
    rm -f /usr/share/keyrings/webmin.gpg
    print_success "Webmin GPG key removed"
else
    print_warn "Webmin GPG key not found"
fi

# Remove Webmin configuration directory (optional)
read -p "Do you want to remove Webmin configuration files? (yes/no): " -r
echo ""
if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    print_info "Removing Webmin configuration..."
    if [ -d /etc/webmin ]; then
        rm -rf /etc/webmin
        print_success "Webmin configuration removed"
    fi
    if [ -d /var/webmin ]; then
        rm -rf /var/webmin
        print_success "Webmin data directory removed"
    fi
else
    print_info "Keeping Webmin configuration files"
fi

# Update package index
print_info "Updating package index..."
apt-get update -y

# Clean up
print_info "Cleaning up..."
apt-get autoremove -y
apt-get autoclean -y

echo ""
print_success "Webmin has been successfully uninstalled!"
echo ""
print_info "If you want to reinstall Webmin later, run:"
echo "   curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/webmin/install.sh | sudo bash"
echo ""

exit 0