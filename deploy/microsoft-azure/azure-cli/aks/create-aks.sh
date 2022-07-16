#!/bin/bash
echo "\r\n====> Create AKS in Microsoft Azure"
echo "Running create-dns.sh script.."
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

az aks create \
    --resource-group $RG \
    --name $AKS_NAME \
    --vm-set-type VirtualMachineScaleSets \
    --node-count $NODECOUNT \
    --load-balancer-sku standard \
    --node-vm-size $NODESIZE \
    --generate-ssh-keys \
    --location $LOCATION

az aks get-credentials \
    --name $AKS_NAME \
    --resource-group $RG
    
echo "AKS is created: COMPLETED \r\n"