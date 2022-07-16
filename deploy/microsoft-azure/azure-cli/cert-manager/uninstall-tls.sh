#!/bin/bash
echo "\r\n====> Uninstall Cert-Manager in Microsoft Azure"
echo "Running uninstall-tls.sh script.."
set -e


# Clean up the test resources.
# kubectl delete -f test-resources.yaml
kubectl delete -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.crds.yaml

kubectl  delete ns cert-manager

echo "Cert-Manager is deleted: COMPLETED \r\n"