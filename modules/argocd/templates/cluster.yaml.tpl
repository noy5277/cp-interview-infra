apiVersion: v1
kind: Secret
metadata:
  name: ${cluster_name}
  namespace: ${argocd_namespace}
  labels:
    argocd.argoproj.io/secret-type: cluster
type: Opaque
stringData:
  name: ${cluster_display_name}
  server: ${cluster_server}
  config: |
    ${config_json}
