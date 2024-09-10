#!/bin/bash

# Take inputs for domain, email, password, and swap size
read -p "Enter domain (e.g., example.com): " domain
read -p "Enter email: " email
read -s -p "Enter password: " password
echo
read -p "Enter swap size in GB: " swap_gb

# Convert swap size from GB to MB
swap_mb=$((swap_gb * 1024))

# Update system and install necessary packages
apt update && apt install -y sudo htop

# Set the system timezone
sudo timedatectl set-timezone Asia/Kolkata

# Create a test directory and move into it
mkdir test && cd test

# Download and execute swap creation script
wget -O swap.sh https://raw.githubusercontent.com/advance-things/linux-swap/main/swap.sh
chmod +x swap.sh
./swap.sh -s "$swap_mb" -f /swapfile -F true

# Download Hestia Control Panel installer
wget https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh

# Run Hestia installer with dynamic inputs
bash hst-install.sh --hostname "$domain" --email "$email" --password "$password" --apache no --phpfpm no --vsftpd no --sieve yes --clamav no --spamassassin no
