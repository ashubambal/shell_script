#!/bin/bash
set -e  # Exit on error

# --- Self-fix Windows CRLF issue ---
# If file contains CRLF, remove CR
if grep -q $'\r' "$0"; then
    echo "🔄 Fixing Windows CRLF line endings..."
    sed -i 's/\r$//' "$0"
    echo "✅ Fixed line endings. Please re-run the script."
    exit 0
fi

# Detect if sudo is needed
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
else
    SUDO=""
fi

echo "🚀 Updating Ubuntu System..."
$SUDO apt update -y
echo "✅ System has been updated"
echo "###############################################################################"

echo "📦 Installing GPG and required packages..."
$SUDO apt-get install -y wget gnupg software-properties-common
echo "✅ GPG and dependencies installed"
echo "###############################################################################"

echo "🔑 Installing HashiCorp's GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
$SUDO tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "✅ GPG key installed"
echo "###############################################################################"

echo "🔍 Verifying the GPG key's fingerprint..."
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "✅ GPG key fingerprint verified"
echo "###############################################################################"

echo "📝 Adding HashiCorp repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" \
| $SUDO tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

echo "🔄 Updating package list..."
$SUDO apt update -y
echo "✅ Package list updated"
echo "###############################################################################"

echo "⚙️ Installing Terraform..."
$SUDO apt install -y terraform
echo "✅ Terraform installation completed"
echo "###############################################################################"

terraform -version

