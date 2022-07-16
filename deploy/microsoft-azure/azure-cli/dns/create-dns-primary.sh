#!/bin/bash
echo "\r\n====> Create DNS in Microsoft Azure"
echo "Running create-dns-primary.sh script.."
set -e

LOCATION=${LOCATION}
RG=${RG}

echo "================================"
echo "\$DOMAIN_NAME_PRIMARY:      $DOMAIN_NAME_PRIMARY"
echo "\$RG:           $RG"
echo "================================"

# Verify if we want to proceed
read -p "Are you sure you want to create primary-dns [y/N]?"
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    exit
fi

# Create RG for DNS Zone.  If one already exists
# return the id for it.
DNS_RG_ID=$(
    az group create \
    --name $RG \
    --location $LOCATION \
    --query id -o tsv
)
# Create DNS Zone.  If one already exists
# return id for it.
DNS_ZONE_ID=$(
    az network dns zone create \
    -g $RG -n $DOMAIN_NAME_PRIMARY \
    --query id -o tsv
)

echo "DNS is created: COMPLETED \r\n"