#!/bin/bash
# ==========================================================
# Script: deploy_nginx.sh
# Purpose: Install and start Nginx server on Linux
# Author: Your Name
# Usage: bash deploy_nginx.sh
# ==========================================================

set -e  # Exit immediately if a command exits with a non-zero status

# ---- Update packages ----
echo "[INFO] Updating system packages..."
sudo apt-get update -y || sudo yum update -y

# ---- Install Nginx ----
if command -v apt-get &>/dev/null; then
    echo "[INFO] Installing Nginx (Ubuntu/Debian)..."
    sudo apt-get install -y nginx
elif command -v yum &>/dev/null; then
    echo "[INFO] Installing Nginx (Amazon Linux/CentOS)..."
    sudo amazon-linux-extras install nginx1 -y || sudo yum install -y nginx
else
    echo "[ERROR] Unsupported OS package manager!"
    exit 1
fi

# ---- Enable and start Nginx ----
echo "[INFO] Enabling and starting Nginx service..."
sudo systemctl enable nginx
sudo systemctl start nginx

# ---- Verify installation ----
echo "[INFO] Checking Nginx status..."
sudo systemctl status nginx --no-pager

# ---- Firewall configuration (optional) ----
if command -v ufw &>/dev/null; then
    echo "[INFO] Allowing HTTP (80) and HTTPS (443) traffic..."
    sudo ufw allow 'Nginx Full'
fi

# ---- Deployment success message ----
echo "=========================================================="
echo "[SUCCESS] Nginx has been deployed successfully!"
echo "Access your server at: http://$(curl -s ifconfig.me)"
echo "=========================================================="
