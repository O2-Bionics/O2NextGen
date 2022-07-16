#!/bin/bash
echo "\r\n====> create  DNS  records in Microsoft Azure"
echo "Running create-primary-dns.sh script.."
set -e

LOCATION=${LOCATION}
RG=${RG}
IP=10.10.10.10

echo "================================"
echo "\$DOMAIN_NAME_PRIMARY:      $DOMAIN_NAME_PRIMARY"
echo "\$RG:               $RG"
echo "\$IP:               $IP"
echo "================================"


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
# set public IP
IP=$PUBLIC_IP

#https://docs.microsoft.com/en-us/azure/dns/dns-getstarted-cli
DNS_NAME=$DOMAIN_NAME_PRIMARY
createRecord(){
     echo "create dnsRecord = $1.$DNS_NAME"
    az network dns record-set a add-record -g $RG -z $DNS_NAME -n $1 -a $IP
}

createDNSForRecordProductionAndStage(){
    stageName=.staging
    stageDNS="$1$stageName"
    createRecord $1
    createRecord $stageDNS
}

createRecordSpecial(){
    IP_SP=$2
     echo "create dnsRecord = $1.$DNS_NAME"
    az network dns record-set a add-record -g $RG -z $DNS_NAME -n $1 -a $IP_SP
}

createDNSForRecordProductionAndStage "www"
createDNSForRecordProductionAndStage "slink"
createRecordSpecial "conf-free" "35.170.204.88"
createRecordSpecial "@"

# # Get-AzDnsRecordSet -ZoneName $DOMAIN_NAME -ResourceGroupName $RG

# # New-AzDnsRecordSet -Name www -RecordType A -ZoneName $DOMAIN_NAME -ResourceGroupName $RG -Ttl 3600 -DnsRecords (New-AzDnsRecordConfig -IPv4Address $IP)
# # # app.dns-name.com
# # New-AzDnsRecordSet -Name app -RecordType A -ZoneName $DOMAIN_NAME -ResourceGroupName $RG -Ttl 3600 -DnsRecords (New-AzDnsRecordConfig -IPv4Address "$IP")

# # Run the following cmdlet to get the list of name servers for your zone:
# az network dns record-set ns show --resource-group $RG --zone-name $DOMAIN_NAME --name @

# # # app.dns-name.com
# # New-AzDnsRecordSet -Name identity -RecordType A -ZoneName $DOMAIN_NAME -ResourceGroupName $RG -Ttl 3600 -DnsRecords (New-AzDnsRecordConfig -IPv4Address "$IP")
# # Get-AzDnsRecordSet -ZoneName $DOMAIN_NAME -ResourceGroupName $RG
# az network dns record-set list -g $RG -z $DOMAIN_NAME

# nslookup www.contoso.xyz <name server name>
# nslookup www.contoso.xyz ns1-08.azure-dns.com.
echo "DNS  records is created: COMPLETED \r\n"