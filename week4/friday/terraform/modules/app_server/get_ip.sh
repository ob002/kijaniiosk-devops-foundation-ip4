#!/usr/bin/env bash
# Read the JSON query from Terraform
eval "$(jq -r '@sh "NAME=\(.name)"')"

# Query multipass for the IP
IP=$(multipass info "$NAME" | grep IPv4 | awk '{print $2}')

# Output JSON back to Terraform
jq -n --arg ip "$IP" '{"ip": $ip}'
