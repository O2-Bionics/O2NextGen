#!/bin/bash


# TRY THIS:
# az group delete --resource-group MyResourceGroup
# Delete a resource group.

# az group create --location westus --resource-group MyResourceGroup
# Create a new resource group in the West US region.

# az group list --query "[?location=='westus']"
# List all resource groups located in the West US region.

echo "\r\n====> Delete Resource Groups in Microsoft Azure"
echo "Running delete-rs.sh script.."
set -e

echo "================================"
echo "\$LOCATION:     $LOCATION"
echo "\$RG:           $RG"
echo "================================"

# az group list --query "[?location=='$LOCATION']"

# Verify if we want to proceed
read -p "Are you sure you wish to delete an Resource Groups [y/N]?"
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    exit
fi

az group delete --resource-group $RG
echo "Resource Groups is deleted: COMPLETED \r\n"