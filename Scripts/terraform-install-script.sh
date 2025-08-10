echo "Updating Ubuntu System"
sudo apt update -y
echo "Syetem has been updated"
echo "###############################################################################"
#!/bin/bash

echo "Updating Ubuntu System"
sudo apt update -y
echo "Syetem has been updated"
echo "###############################################################################"

echo "GPG signature and install packages"
sudo apt-get install -y gnupg software-properties-common
echo "Completed GPG signature and install packages"
echo "###############################################################################"

echo "Install HashiCorp's GPG key"
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "Completed Install HashiCorp's GPG key"
echo "###############################################################################"

echo "Verify the GPG key's fingerprint"
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "Verified the GPG key's fingerprint"
echo "###############################################################################"

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "Updating Ubuntu System"
sudo apt update -y
echo "Syetem has been updated"
echo "###############################################################################"

echo "Installing Terrform"
sudo apt install terraform
echo "Terrafrom installation completed"
echo "###############################################################################"

