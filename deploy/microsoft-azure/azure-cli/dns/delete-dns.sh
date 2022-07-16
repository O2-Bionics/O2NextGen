#!/bin/bash
echo "\r\n====> Create DNS in Microsoft Azure"
echo "Running delete-dns.sh script.."
set -e

LOCATION=${LOCATION}
RG=${RG}

echo "================================"
echo "\$DOMAIN_NAME:      $DOMAIN_NAME"
echo "\$RG:           $RG"
echo "================================"

# Verify if we want to proceed
read -p "Are you sure you want to delete master-dns [y/N]?"
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    exit
fi

# Create DNS Zone.  If one already exists
# return id for it.
    az network dns zone delete \
    -g $RG -n $DOMAIN_NAME \


echo "DNS is created: COMPLETED \r\n"