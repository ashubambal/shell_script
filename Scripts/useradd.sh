#!/bin/bash

for ((i=1;i<=10;i++))
do
read -p "Enter username " username
sudo useradd -m $username
done
