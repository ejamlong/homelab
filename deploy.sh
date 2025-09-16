#!/bin/bash
set -e

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

# Ensure running as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}This script must be run as root!${NC}"
    exit 1
fi

# Function to check command existence
check_cmd() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install terraform & packer from HashiCorp repo
install_hashicorp_tools() {
    echo -e "${GREEN}Adding HashiCorp repo (Terraform & Packer)...${NC}"
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt-get update -y
    apt-get install -y terraform packer
}

# Function to install ansible
install_ansible() {
    echo -e "${GREEN}Installing Ansible...${NC}"
    apt-get update -y
    apt-get install -y software-properties-common
    add-apt-repository --yes --update ppa:ansible/ansible
    apt-get install -y ansible
}

echo -e "${GREEN}Checking required tools...${NC}"

if check_cmd terraform && check_cmd packer; then
    echo -e "${GREEN}Terraform & Packer already installed.${NC}"
else
    echo -e "${RED}Terraform and/or Packer not found.${NC}"
    install_hashicorp_tools
fi

if check_cmd ansible; then
    echo -e "${GREEN}Ansible already installed.${NC}"
else
    echo -e "${RED}Ansible not found.${NC}"
    install_ansible
fi

echo -e "${GREEN}All dependencies are installed and ready!${NC}"
