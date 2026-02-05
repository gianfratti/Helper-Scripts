#!/bin/bash
# Git Installation Script
# Author: gianfratti
# Description: Installs Git version control system on Ubuntu/Debian systems

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

print_info "Starting Git installation..."
echo ""

# Update package index
print_info "Updating package index..."
apt-get update -y

# Install Git
print_info "Installing Git..."
apt-get install git -y

# Verify installation
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    print_success "Git installed successfully: $GIT_VERSION"
else
    print_error "Git installation failed"
    exit 1
fi

echo ""
print_success "Git installation completed!"
echo ""
print_info "Next steps:"
print_info "1. Configure your Git identity:"
echo "   git config --global user.name \"Your Name\""
echo "   git config --global user.email \"your.email@example.com\""
echo ""
print_info "2. Verify configuration:"
echo "   git config --list"
echo ""
print_info "3. Generate SSH key (optional, for GitHub/GitLab):"
echo "   ssh-keygen -t ed25519 -C \"your.email@example.com\""
echo ""

exit 0