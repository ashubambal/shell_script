#!/bin/bash

# update the system

sudo apt-get update -y

# Install Nginx

sudo apt-get install nginx -y

# Start and Enable Nginx

sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
