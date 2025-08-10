#!/bin/bash

# update the system
echo "updating the system....."
sudo apt-get update -y
echo "system has been updated"

# Install nginx
echo "Installing Nginx....."
sudo apt install nginx -y
echo "Nginx installation completed"

# Start and Enable Nginx
echo "Starting Nginx ..."
sudo systemctl start nginx
echo "Nginx Started"
echo "Enabling Nginx ..."
sudo systemctl enable nginx
echo "Nginx has been enabled"

# Serve webpage
echo "<h1> Hello Dosto Namaskar</h1>" > index.html

cp index.html /var/www/html
