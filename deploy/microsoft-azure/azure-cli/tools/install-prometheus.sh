
helm repo add stable https://charts.helm.sh/stable
helm repo update


# # If using helm for the first time, add the stable repo
# helm repo add stable https://kubernetes-charts.storage.googleapis.com/

kubectl create namespace monitoring
# kubectl create ns monitoring
helm install prometheus stable/prometheus-operator --namespace monitoring
# Check pods
kubectl --namespace monitoring get pods



# helm install promitor-agent-scraper promitor/promitor-agent-scraper \
#   --values your/path/to/metric-declaration.yaml

# cat > promitor-scrape-config.yaml <<EOF
# extraScrapeConfigs: |
#   - job_name: promitor-agent-scraper
#     metrics_path: /metrics
#     static_configs:
#       - targets:
#         - promitor-agent-scraper.default.svc.cluster.local:80
# EOF
# helm install stable/prometheus -f promitor-scrape-config.yaml