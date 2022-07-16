#!/bin/bash
echo "\r\n====> Exporting vars for local machine"
echo "Running export-vars.sh script.."
echo "================================================"
export LOCATION=centralus
export RG=products-group  #new version products-group | old version o2bionics-group
export DOMAIN_NAME=o2bus.com
export DOMAIN_NAME_PRIMARY=pfr-centr.com

export AKS_NAME=o2nextgen-aks #new version o2nextgen-aks | old version o2-aks
export NODECOUNT=1
export NODESIZE=Standard_D4as_v5  # Standard_F2s | Standard_D4s_v4 | Standard_DS2_v2 | Standard_B2s

export LETS_ENCRYPT_EMAIL=live-dev@hotmail.com


echo "\$LOCATION | $LOCATION"
echo "\$RG | $RG"

echo "\$DOMAIN_NAME | $DOMAIN_NAME"

echo "\$AKS_NAME:      $AKS_NAME"
echo "\$NODECOUNT:      $NODECOUNT"
echo "\$NODESIZE:      $NODESIZE"

echo "\$LETS_ENCRYPT_EMAIL:      $LETS_ENCRYPT_EMAIL"

echo "================================================"
echo "Export vars: COMPLETED \r\n"
