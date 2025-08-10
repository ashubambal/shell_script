#!/bin/bash
# Script to install Helm on Linux / MacOS
# Author: Ashutosh Automation :)

set -e  # Exit on error

HELM_VERSION="v3.15.4"  # Change version if needed
OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

echo "[INFO] Installing Helm ${HELM_VERSION} for ${OS}/${ARCH}..."

# Map architecture names
if [ "$ARCH" == "x86_64" ]; then
    ARCH="amd64"
elif [ "$ARCH" == "aarch64" ] || [ "$ARCH" == "arm64" ]; then
    ARCH="arm64"
else
    echo "[ERROR] Unsupported architecture: $ARCH"
    exit 1
fi

# Download Helm tarball
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

echo "[INFO] Downloading Helm..."
curl -fsSL -o helm.tar.gz \
  "https://get.helm.sh/helm-${HELM_VERSION}-${OS}-${ARCH}.tar.gz"

# Extract and move binary
echo "[INFO] Extracting Helm..."
tar -zxvf helm.tar.gz
sudo mv ${OS}-${ARCH}/helm /usr/local/bin/helm

# Verify installation
echo "[INFO] Verifying Helm installation..."
helm version

# Cleanup
cd -
rm -rf "$TMP_DIR"

echo "[SUCCESS] Helm ${HELM_VERSION} installed successfully!"

