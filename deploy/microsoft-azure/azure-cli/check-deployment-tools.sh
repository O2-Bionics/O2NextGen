#!/bin/bash
echo "\r\n====> Checking deployment tools"
echo "Running check-deployment-tools.sh script.."
set -e
validateTools() {
    command -v az 2&> /dev/null
    if [ $? -ne 0 ]; then
        echo "ERROR: Requires Azure CLI (az).  Aborting..."
        exit 1
    fi
    command -v az 2&> /dev/null
    if [ $? -ne 0 ]; then
        echo "ERROR: Requires Azure CLI (az).  Aborting..."
        exit 1
    fi
    command -v kubectl 2&> /dev/null
    if [ $? -ne 0 ]; then
        echo "ERROR: Requires Kubectl (kubectl). Aborting..."
        exit 1
    fi
    command -v helm 2&> /dev/null
    if [ $? -ne 0 ]; then
        echo "ERROR: Requires Helm v3.1.2_1+ (helm). Aborting..."
        exit 1
    fi
}
validateTools
echo "Tools for deploayment AKS: OK! \r\n"