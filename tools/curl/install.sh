#!/bin/bash
# cURL Installation Script
# Author: gianfratti
# Description: Installs cURL command-line tool on Ubuntu/Debian systems

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

print_info "Starting cURL installation..."
echo ""

# Update package index
print_info "Updating package index..."
apt-get update -y

# Install cURL
print_info "Installing cURL..."
apt-get install curl -y

# Verify installation
if command -v curl &> /dev/null; then
    CURL_VERSION=$(curl --version | head -n 1)
    print_success "cURL installed successfully: $CURL_VERSION"
else
    print_error "cURL installation failed"
    exit 1
fi

echo ""
print_success "cURL installation completed!"
echo ""
print_info "Test cURL:"
echo "   curl https://www.google.com"
echo ""
print_info "Download a file:"
echo "   curl -O https://example.com/file.txt"
echo ""
print_info "Send POST request:"
echo "   curl -X POST -d 'data=example' https://api.example.com"
echo ""

exit 0