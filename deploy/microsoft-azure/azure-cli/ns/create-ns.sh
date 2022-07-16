#!/bin/bash
echo "\r\n====> Create Deployment namespace in Microsoft Azure"
echo "Running install-ns.sh script.."
set -e


# Create the namespace for deployment
kubectl create namespace production
kubectl create namespace staging


echo "Deployment namespace is created: COMPLETED \r\n"