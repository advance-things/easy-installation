#!/bin/bash

# Create a Docker network if it doesn't exist
docker network create vaultwarden_network 2>/dev/null || true

# Prompt the user for SMTP configuration
read -p "SMTP Host: " SMTP_HOST
read -p "SMTP From: " SMTP_FROM
read -p "SMTP From Name: " SMTP_FROM_NAME
read -p "SMTP Security (e.g., starttls): " SMTP_SECURITY
read -p "SMTP Port: " SMTP_PORT
read -p "SMTP Username: " SMTP_USERNAME
read -s -p "SMTP Password: " SMTP_PASSWORD
echo # Newline for password input

# Prompt the user for other configuration parameters
read -p "Domain (e.g., https://homevault.example.org): " DOMAIN
read -p "Admin Token: " ADMIN_TOKEN

# Prompt the user for the port to map
read -p "Port to map to 8062 (e.g., 8080): " CUSTOM_PORT

# Define the absolute path for the volume
VOLUME_PATH="$(pwd)/vw-data/"

# Run the VaultWarden container with user input
docker run -d \
    --name vaultwarden \
    --restart always \
    --network vaultwarden_network \
    -v "$VOLUME_PATH":/data/ \
    -p "$CUSTOM_PORT":80 \
    -e SMTP_HOST="$SMTP_HOST" \
    -e SMTP_FROM="$SMTP_FROM" \
    -e SMTP_FROM_NAME="$SMTP_FROM_NAME" \
    -e SMTP_SECURITY="$SMTP_SECURITY" \
    -e SMTP_PORT="$SMTP_PORT" \
    -e SMTP_USERNAME="$SMTP_USERNAME" \
    -e SMTP_PASSWORD="$SMTP_PASSWORD" \
    -e LOGIN_RATELIMIT_MAX_BURST=10 \
    -e LOGIN_RATELIMIT_SECONDS=60 \
    -e DOMAIN="$DOMAIN" \
    -e ADMIN_TOKEN="$ADMIN_TOKEN" \
    -e INVITATION_ORG_NAME=HomeVault \
    -e INVITATIONS_ALLOWED=true \
    -e SIGNUPS_ALLOWED=false \
    -e SIGNUPS_VERIFY=true \
    -e SIGNUPS_VERIFY_RESEND_TIME=3600 \
    -e SIGNUPS_VERIFY_RESEND_LIMIT=6 \
    -e EMERGENCY_ACCESS_ALLOWED=true \
    -e SENDS_ALLOWED=true \
    -e WEB_VAULT_ENABLED=true \
    vaultwarden/server:latest

# Get the IP address of the host
HOST_IP=$(docker network inspect -f '{{range .IPAM.Config}}{{.Gateway}}{{end}}' vaultwarden_network)

# Provide a useful message with the link to access the service
echo "VaultWarden is now running and accessible at:"
echo "http://$HOST_IP:$CUSTOM_PORT"
