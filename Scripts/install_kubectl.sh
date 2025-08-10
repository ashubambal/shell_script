#!/bin/bash

echo "Updating system"
sudo apt update -y
echo "Update completed"
echo "##################################################################################"

echo "Downloading the latest release"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo "Downloading latest release completed"
echo "##################################################################################"

echo "Downloading the kubectl checksum file"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "Downloading the kubectl checksum file completed"
echo "##################################################################################"

echo "Validating the kubectl binary against the checksum file"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
echo "Validating the kubectl binary against the checksum file completed"
echo "##################################################################################"


echo "Installing kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "Installation completed"
echo "##################################################################################"

echo "Adding permission"
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
echo "##################################################################################"

kubectl version --client
