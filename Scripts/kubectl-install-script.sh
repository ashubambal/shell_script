#!/bin/bash
# Self-clean carriage returns if running in WSL or Windows-edited file
sed -i 's/\r$//' "$0"

# Fix CRLF line endings if present
if grep -q $'\r' "$0"; then
    echo "🔄 Fixing Windows CRLF line endings..."
    sed -i 's/\r$//' "$0"
    echo "✅ Fixed. Please re-run the script."
    exit 0
fi

set -e  # Exit immediately if any command fails

# Detect if sudo is needed
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
else
    SUDO=""
fi

echo "🚀 Updating system"
$SUDO apt update -y
echo "✅ Update completed"
echo "##################################################################################"

echo "📦 Installing required dependencies"
$SUDO apt install -y curl coreutils
echo "✅ Dependencies installed"
echo "##################################################################################"

echo "📥 Downloading the latest release"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo "✅ Downloading latest release completed"
echo "##################################################################################"

echo "📥 Downloading the kubectl checksum file"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "✅ Checksum file downloaded"
echo "##################################################################################"

echo "🔍 Validating the kubectl binary"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
echo "✅ Validation completed"
echo "##################################################################################"

echo "⚙️ Installing kubectl"
$SUDO install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "✅ Installation completed"
echo "##################################################################################"

echo "📂 Adding permission & moving binary"
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
echo "##################################################################################"

echo "🔎 Checking kubectl version"
kubectl version --client

