```bash
sudo bin/hack.sh
bin/git.sh
source update.sh
```

# k3s

```bash
kubectl apply -f letsencrypt-issuer.yaml

```

## openfaas

```bash
# Install chart
helm install openfaas openfaas/openfaas -n openfaas -f values.openfaas.yaml
PASSWORD=$(kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode)
echo "OpenFaaS admin password: $PASSWORD"
```

### GPU

```bash
kubectl apply -f- << EOF
kind: Profile
apiVersion: openfaas.com/v1
metadata:
  name: withgpu
  namespace: openfaas
spec:
    tolerations:
    - key: "gpu"
      operator: "Exists"
      effect: "NoSchedule"
    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: gpu
                operator: In
                values:
                - installed
EOF
```


## jupyterhub

```bash
# https://zero-to-jupyterhub.readthedocs.io/en/latest/jupyterhub/installation.html
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
kubectl create namespace jupyter
helm upgrade --cleanup-on-fail \
  --install jupyter jupyterhub/jupyterhub \
  -n jupyter \
  -f values.jupyterhub.yaml \
  --set proxy.secretToken=$(openssl rand -hex 32) \
  --timeout 3000s
```