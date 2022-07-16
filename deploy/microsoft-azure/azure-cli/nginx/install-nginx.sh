#!/bin/bash
echo "\r\n====> Install NGINX Ingress controller (Azure Public IP)"
echo "Running install-nginx.sh script.."
set -e
# This script creates an Azure Public IP and binds
# an the NGINX Ingress controller to it

# aksName="o2-aks"
# resourceGroup = "o2bionics-group"

RG=${RG}
AKS_NAME=${AKS_NAME}

set -e 

if [[ -z "$RG" || -z "$AKS_NAME" ]]; then
    echo "ERROR: Some Environment variables are missing!"
    echo -e "ERROR: These are required:\n"
    echo "       RG: Resource Group"
    echo "       AKS_NAME: AKS.Cluster Name"
    echo "       LOCATION (optional): Azure region.  Default is usgovvirginia"
    exit 1
fi

LOCATION=${LOCATION}
K8S_CONTEXT=$(kubectl config current-context)

echo "AKS_NAME:             $AKS_NAME"
echo "RG:                   $RG"
echo "LOCATION:             $LOCATION"
echo -e "K8S_CONTEXT:          $K8S_CONTEXT\n"

# Verify if we want to proceed
read -p "Are you sure you want to install NGINX [y/N]?"
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    exit
fi

# Get the Resource Group of our AKS Cluster
AKS_CLUSTER_RG=$(
    az aks show \
    --resource-group $RG \
    --name $AKS_NAME \
    --query nodeResourceGroup -o tsv
)
# Create a Public IP and get the id of the address.  If one exists already
# in the RG with the same name.  The existing IP will be returned.
PUBLIC_IP=$(
    az network public-ip create \
    --resource-group $AKS_CLUSTER_RG \
    --name IP-PublicIP1 \
    --sku Standard \
    --allocation-method static \
    --query publicIp.ipAddress -o tsv
)
# Add stable chart repo
# helm repo add stable https://kubernetes-charts.storage.googleapis.com (old repo)
helm repo add stable https://charts.helm.sh/stable
# Create namespace for Ingress
kubectl create namespace ingress

# Use Helm to deploy an NGINX ingress controller with static IP
helm install nginx-ingress stable/nginx-ingress  \
    --wait --namespace ingress \
    --set controller.replicaCount=2 \
    --set controller.service.loadBalancerIP="$PUBLIC_IP" \
    --set controller.publishService.enabled=true \
    --set controller.publishService.pathOverride=ingress/nginx-ingress-controller


# kubectl apply -f identity-nginx.yaml --namespace=production