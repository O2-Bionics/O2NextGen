#!/bin/bash
echo "\r\n====> DELETE AKS in Microsoft Azure"
echo "Running delete-dns.sh script.."
set -e

LOCATION=${LOCATION}
RG=${RG}
NODECOUNT=${NODECOUNT-1}
NODESIZE=${NODESIZE-Standard_F2s}

echo "================================"
echo "\$LOCATION:      $LOCATION"
echo "\$RG:           $RG"
echo "\$AKS_NAME:      $AKS_NAME"
echo "\$NODECOUNT:      $NODECOUNT"
echo "\$NODESIZE:      $NODESIZE"
echo "================================"

# Verify if we want to proceed
read -p "Are you sure you wish to delete an AKS Cluster [y/N]?"
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    exit
fi

az aks delete \
    --resource-group $RG \
    --name $AKS_NAME
    
echo "AKS is deleted: COMPLETED \r\n"