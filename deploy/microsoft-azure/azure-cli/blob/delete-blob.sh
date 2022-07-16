#!/bin/bash
echo "\r\n====> Delete BLOB Storage in Microsoft Azure"
echo "Running delete-blob.sh script.."
set -e

echo "================================"
echo "\$DOMAIN_NAME:      $DOMAIN_NAME"
echo "\$RG:           $RG"
echo "================================"

az storage container delete --name  o2-storage

echo "Deleted BLOB Storage: COMPLETED \r\n"