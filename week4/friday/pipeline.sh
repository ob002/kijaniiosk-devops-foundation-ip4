#!/bin/bash
set -euo pipefail

# Determine execution mode (default to multipass)
MODE=${1:-multipass}

echo "=========================================="
echo "KijaniKiosk IaC Pipeline"
echo "Mode: $MODE"
echo "Started: $(date)"
echo "=========================================="

# Get the directory where the script is located to ensure relative paths work
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# --- Step 1: Terraform Apply ---
echo "[1/4] Running Terraform..."
cd terraform
terraform init -upgrade
terraform apply -auto-approve

# --- Step 2: Extract IPs and write inventory ---
echo "[2/4] Extracting server IPs and generating inventory..."

# We are ALREADY in the terraform directory, so we can run terraform output directly
API_IP=$(terraform output -raw api_server_ip)
PAYMENTS_IP=$(terraform output -raw payments_server_ip)
LOGS_IP=$(terraform output -raw logs_server_ip)

# Now go back up to the root directory
cd ..

cat > ansible/inventory.ini << INVENTORY_EOF
[kijaniiosk]
api ansible_host=$API_IP
payments ansible_host=$PAYMENTS_IP
logs ansible_host=$LOGS_IP
INVENTORY_EOF

echo "Generated inventory.ini:"
cat ansible/inventory.ini

# --- Step 3: Ansible Playbook ---
echo "[3/4] Running Ansible playbook..."
cd ansible
ansible-playbook -i inventory.ini kijaniiosk.yml
cd ..

# --- Step 4: Completion ---
echo "[4/4] Pipeline complete!"
echo "Finished: $(date)"
echo "=========================================="
