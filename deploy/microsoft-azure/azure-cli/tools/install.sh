#!/bin/bash
echo "\r\n====> Install Analize Tools in AKS"
echo "Running tools.sh script.."
set -e

echo "\$AKS_NAME:      $AKS_NAME"
echo "\$RG:      $RG"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
kubectl cluster-info

# Go to Cluster page in browser
# az aks browse --resource-group $RG --name $AKS_NAME

# create auto(dont't running it)
# echo "create service account for UI dashboard"
# kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

# Set the admin kubeconfig with az aks get-credentials -a --resource-group <RG_NAME> --name <CLUSTER_NAME>
# Select Kubeconfig and click Choose kubeconfig file to open file selector
# Select your kubeconfig file (defaults to $HOME/.kube/config)
# Click Sign In
az aks get-credentials -a --resource-group $RG --name $AKS_NAME

echo "tools is installed: COMPLETED \r\n"