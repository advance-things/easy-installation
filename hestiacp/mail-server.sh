#!/bin/bash

# Initialize variables
domain=""
email=""
password=""
swap_gb=""
timezone="Asia/Kolkata"  # Default timezone

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --domain) domain="$2"; shift ;;
        --email) email="$2"; shift ;;
        --password) password="$2"; shift ;;
        --swap) swap_gb="$2"; shift ;;
        --timezone) timezone="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Function to check if an argument is provided; if not, prompt the user
function get_input() {
    local prompt="$1"
    local value="$2"
    
    if [ -z "$value" ]; then
        read -p "$prompt" value
    fi

    echo "$value"
}

# Assign input if not already provided by arguments
domain=$(get_input "Enter domain (e.g., example.com): " "$domain")
email=$(get_input "Enter email: " "$email")
password=$(get_input "Enter password: " "$password")
swap_gb=$(get_input "Enter swap size in GB: " "$swap_gb")
timezone=$(get_input "Enter timezone (e.g., Asia/Kolkata): " "$timezone")

# Convert swap size from GB to MB
swap_mb=$((swap_gb * 1024))

# Update system and install necessary packages
apt update && apt install -y sudo htop

# Set the system timezone
sudo timedatectl set-timezone "$timezone"

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
