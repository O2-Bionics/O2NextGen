#!/bin/bash
echo "\r\n====> Create BLOB Stogare in Microsoft Azure"
echo "Running create-blob.sh script.."
# https://markheath.net/post/manage-blob-storage-azure-cli
set -e

LOCATION=${LOCATION}
RG=${RG}

echo "================================"
echo "\$DOMAIN_NAME:      $DOMAIN_NAME"
echo "\$RG:           $RG"
echo "================================"


storageAccount="o2nextgen"

# create our resource group
az group create -n $RG -l $LOCATION

# create a storage account
az storage account create -n $storageAccount -g $RG -l $LOCATION --sku Standard_LRS

# az storage container create -n o2-storage --resource-group $RG --public-access blob
# az storage container delete --name  o2-storage
# az ad signed-in-user show --query objectId -o tsv | az role assignment create \
#     --role "Storage Blob Data Contributor" \
#     --assignee @- \
#     --scope "/subscriptions/<subscription>/resourceGroups/$RG/providers/Microsoft.Storage/storageAccounts/<storage-account>"

# az storage container create \
#     --account-name "<storage-account>" \
#     --name <container> \
#     --auth-mode login

echo "Created BLOB Storage: COMPLETED \r\n"