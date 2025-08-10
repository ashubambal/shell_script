#!/bin/bash

# Script to install AWS CLI v2 on Ubuntu

set -e  # Exit immediately if a command fails

echo "� Installing AWS CLI v2 on Ubuntu..."

# Update package index
sudo apt update -y

# Install required dependencies
sudo apt install -y unzip curl

# Download AWS CLI v2 ZIP
echo "� Downloading AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
echo "� Extracting AWS CLI v2..."
unzip awscliv2.zip

# Run the installer
echo "⚙️ Installing AWS CLI v2..."
sudo ./aws/install

# Verify installation
echo "✅ Verifying AWS CLI installation..."
aws --version

# Clean up files
rm -rf aws awscliv2.zip

echo "� AWS CLI v2 installation completed successfully!"

