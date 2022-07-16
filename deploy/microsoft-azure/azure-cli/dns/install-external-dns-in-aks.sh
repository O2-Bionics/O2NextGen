#!/bin/bash
echo "\r\n====> Set external DNS in Microsoft Azure"
echo "Running create-dns.sh script.."
set -e

DNS_RG=${RG}
AZURE_CLOUD=${AZURE_CLOUD-AzureUSGovernmentCloud}
LOCATION=${LOCATION}
SP_NAME=${SP_NAME-AKS_DNS_SP_$RANDOM}
K8S_CONTEXT=$(kubectl config current-context)

if [[ -z "$DOMAIN_NAME" || -z "$RG" ]]; then
    echo "ERROR: Some Environment variables are missing!"
    echo -e "ERROR: The following are required:\n"
    echo "       DNS_RG:                    Resource Group for DNS Zone"
    echo "       DOMAIN_NAME:               Domain Name (ie. example.com)"
    echo "       LOCATION (optional):       Azure region.  Default is usgovvirginia"
    echo "       AZURE_CLOUD (optional):    Selected Azure Cloud.  "
    echo "               Default is AzureUSGovernmentCloud."
    echo "               Use 'AzurePublicCloud' for Commercial"
    exit 1
fi

echo "DNS_RG:           $DNS_RG"
echo "DOMAIN_NAME:      $DOMAIN_NAME"
echo "LOCATION:         $LOCATION"
echo "AZURE_CLOUD:      $AZURE_CLOUD"
echo -e "K8S_CONTEXT:      $K8S_CONTEXT"
echo "SP_NAME           $SP_NAME\n"

# Verify if we want to proceed
read -p "Are you sure you want to install external-dns [y/N]?"
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    exit
fi

# Create RG for DNS Zone.  If one already exists
# return the id for it.
DNS_RG_ID=$(
    az group create \
    --name $DNS_RG \
    --location $LOCATION \
    --query id -o tsv
)
# Create DNS Zone.  If one already exists
# return id for it.
DNS_ZONE_ID=$(
    az network dns zone create \
    -g $DNS_RG -n $DOMAIN_NAME \
    --query id -o tsv
)

# # Create Service Principal
SP_TOKEN=$(az ad sp create-for-rbac -n $SP_NAME -o json)

# Grab info from the Service Principal
SP_APPID=$(echo $SP_TOKEN | jq -e -r 'select(.appId != null) | .appId')
SP_TENANTID=$(echo $SP_TOKEN | jq -e -r 'select(.tenant != null) | .tenant')
SP_PASSWORD=$(echo $SP_TOKEN | jq -e -r 'select(.password != null) | .password')
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# Assign Reader to SP for RG
az role assignment create \
    --role "Reader" \
    --assignee $SP_APPID \
    --scope $DNS_RG_ID 1>/dev/null

# Assign Contributor to SP for DNSZone
az role assignment create \
    --role "Contributor" \
    --assignee $SP_APPID \
    --scope $DNS_ZONE_ID 1>/dev/null

# Add bitnami repo for external-dns chart
helm repo add bitnami https://charts.bitnami.com/bitnami

# Create namespace for external-dns
kubectl create namespace external-dns

# Install external-dns chart
helm install external-dns bitnami/external-dns \
    --wait --namespace external-dns \
    --set provider=azure \
    --set azure.resourceGroup=AzureDNS \
    --set azure.tenantId=$SP_TENANTID \
    --set azure.subscriptionId=$SUBSCRIPTION_ID \
    --set azure.aadClientId=$SP_APPID \
    --set azure.aadClientSecret=$SP_PASSWORD \
    --set azure.cloud=$AZURE_CLOUD \
    --set policy=sync \
    --set domainFilters={$DOMAIN_NAME}

echo "=================================================="
echo "Current DNS Nameservers for $DOMAIN_NAME" 
host -t ns $DOMAIN_NAME 

echo "NOTE: ++++++++++++++++++++++++++++++++++++++++++++"
echo "      Ensure your domain registrar is using"
echo "      the following DNS nameservers for resolution"
echo "      before continuing."
echo "      +++++++++++++++++++++++++++++++++++++++++++++"
az network dns zone show \
    -g $DNS_RG -n $DOMAIN_NAME \
    -o tsv --query nameServers

echo "Set external DNS is created: COMPLETED \r\n"
