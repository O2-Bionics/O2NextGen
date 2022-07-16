# Uninstall/delete the prometheus deployment:
helm delete --namespace monitoring prometheus 

# CRDs created by this chart are not removed by default and should be manually cleaned up
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com

# Finally, delete the namespace
kubectl delete namespace monitoring --cascade=true