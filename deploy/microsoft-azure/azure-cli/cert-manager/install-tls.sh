#!/bin/bash
echo "\r\n====> Install Cert-Manager in Microsoft Azure"
echo "Running install-tls.sh script.."
set -e

# # Install the CustomResourceDefinition resources separately
# # Note: --validate=false is required per https://github.com/jetstack/cert-manager/issues/2208#issuecomment-541311021
# # kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.13/deploy/manifests/00-crds.yaml --validate=false
# kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml --validate=false
# # Create the namespace for cert-manager
# kubectl create namespace cert-manager

# # Label the cert-manager namespace to disable resource validation
# kubectl label namespace cert-manager cert-manager.io/disable-validation=true

# # Add the Jetstack Helm repository
# helm repo add jetstack https://charts.jetstack.io

# # Update your local Helm chart repository cache
# helm repo update

# # Install v0.11 of cert-manager Helm chart
# helm install cert-manager \
#   --namespace cert-manager \
#   --version v1.4.0 \
#   jetstack/c

# Install the CustomResourceDefinition resources using kubectl:
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml
# Create the namespace for cert-manager:
kubectl create namespace cert-manager

# Label the ingress namespace to disable resource validation
kubectl label namespace ingress cert-manager.io/disable-validation=true

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository: 
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache:
helm repo update


# To install the cert-manager Helm chart:
 helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.4.0 \
  # --set installCRDs=true

# Verifying the installation
# kubectl get pods --namespace cert-manager

# cat <<EOF > test-resources.yaml
# apiVersion: v1
# kind: Namespace
# metadata:
#   name: cert-manager-test
# ---
# apiVersion: cert-manager.io/v1
# kind: Issuer
# metadata:
#   name: test-selfsigned
#   namespace: cert-manager-test
# spec:
#   selfSigned: {}
# ---
# apiVersion: cert-manager.io/v1
# kind: Certificate
# metadata:
#   name: selfsigned-cert
#   namespace: cert-manager-test
# spec:
#   dnsNames:
#     - example.com
#   secretName: selfsigned-cert-tls
#   issuerRef:
#     name: test-selfsigned
# EOF

# #Create the test resources.
# kubectl apply -f test-resources.yaml


# Check the status of the newly created certificate. You may need to wait a few seconds before cert-manager processes the certificate request.
# kubectl describe certificate -n cert-manager-test

echo "Cert-Manager is created: COMPLETED \r\n"