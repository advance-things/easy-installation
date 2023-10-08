#!/bin/bash



# Default values
SMTP_HOST=""
SMTP_FROM=""
SMTP_FROM_NAME=""
SMTP_SECURITY=""
SMTP_PORT=""
SMTP_USERNAME=""
SMTP_PASSWORD=""
DOMAIN=""
ADMIN_TOKEN=""
CUSTOM_PORT=""
VOLUME_PATH=""

# Create a Docker network if it doesn't exist
docker network create vaultwarden_network 2>/dev/null || true

# Process command line arguments using getopts
while getopts ":h:f:n:s:p:u:w:d:t:c:" opt; do
  case $opt in
    h)
      SMTP_HOST="$OPTARG"
      ;;
    f)
      SMTP_FROM="$OPTARG"
      ;;
    n)
      SMTP_FROM_NAME="$OPTARG"
      ;;
    s)
      SMTP_SECURITY="$OPTARG"
      ;;
    p)
      SMTP_PORT="$OPTARG"
      ;;
    u)
      SMTP_USERNAME="$OPTARG"
      ;;
    w)
      SMTP_PASSWORD="$OPTARG"
      ;;
    d)
      DOMAIN="$OPTARG"
      ;;
    t)
      ADMIN_TOKEN="$OPTARG"
      ;;
    c)
      CUSTOM_PORT="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      ;;
  esac
done

# If a value is not provided through command line arguments, prompt the user
if [ -z "$SMTP_HOST" ]; then
  read -p "SMTP Host: " SMTP_HOST
fi

if [ -z "$SMTP_FROM" ]; then
  read -p "SMTP From: " SMTP_FROM
fi

if [ -z "$SMTP_FROM_NAME" ]; then
  read -p "SMTP From Name: " SMTP_FROM_NAME
fi

if [ -z "$SMTP_SECURITY" ]; then
  read -p "SMTP Security (e.g., starttls): " SMTP_SECURITY
fi

if [ -z "$SMTP_PORT" ]; then
  read -p "SMTP Port: " SMTP_PORT
fi

if [ -z "$SMTP_USERNAME" ]; then
  read -p "SMTP Username: " SMTP_USERNAME
fi

if [ -z "$SMTP_PASSWORD" ]; then
  read -s -p "SMTP Password: " SMTP_PASSWORD
  echo # Newline for password input
fi

if [ -z "$DOMAIN" ]; then
  read -p "Domain (e.g., https://homevault.example.org): " DOMAIN
fi

if [ -z "$ADMIN_TOKEN" ]; then
  read -p "Admin Token: " ADMIN_TOKEN
fi

if [ -z "$CUSTOM_PORT" ]; then
  read -p "Port to map to 8062 (e.g., 8080): " CUSTOM_PORT
fi

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
domainname=$(echo "$DOMAIN" | sed -E 's/https?:\/\///; s/\/.*//')

#ssl on domain
sudo wget https://raw.githubusercontent.com/thepwnexperts/advance-things/main/linux/vps/nginx-proxy/diff-host/ssl-hsts-http2/nginx-proxy-ssl.sh
sudo chmod +x nginx-proxy-ssl.sh
sudo sh $(pwd)/nginx-proxy-ssl.sh --hsts --http2 -d $domainname -p $CUSTOM_PORT -ph localhost

# Provide a useful message with the link to access the service
echo "VaultWarden is now running and accessible at:"
echo "http://$HOST_IP:$CUSTOM_PORT"
echo "$DOMAIN"
