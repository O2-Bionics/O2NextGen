#!/bin/bash
echo "\r\n====> Create Resource Groups in Microsoft Azure"
echo "Running create-rs.sh script.."
set -e

LOCATION=${LOCATION}
RG=${RG}

echo "================================"
echo "\$LOCATION:          $LOCATION"
echo "\$RG:           $RG"
echo "================================"

az group create -l $LOCATION -n $RG

echo "Resource Groups is created: COMPLETED \r\n"