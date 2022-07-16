cat <<-EOF | kubectl apply --namespace default -f -
apiVersion: cert-manager.io/v1

kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: $LETS_ENCRYPT_EMAIL
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          class: nginx
EOF

cat <<-EOF | kubectl apply --namespace production -f -
apiVersion: cert-manager.io/v1

kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: $LETS_ENCRYPT_EMAIL
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          class: nginx
EOF

cat <<-EOF | kubectl apply --namespace staging -f -
apiVersion: cert-manager.io/v1

kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: $LETS_ENCRYPT_EMAIL
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          class: nginx
EOF