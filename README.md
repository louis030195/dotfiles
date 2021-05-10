```bash
sudo bin/hack.sh
bin/git.sh
source update.sh
```

# k3s

```bash
kubectl apply -f letsencrypt-issuer.yaml
helm install openfaas openfaas/openfaas -n openfaas -f openfaas.yaml
kubectl describe certificate -n openfaas openfaas-crt
# openfaas.yaml Replace letsencrypt-staging with letsencrypt-prod
helm upgrade openfaas -n openfaas --reuse-values -f openfaas.yaml openfaas/openfaas
PASSWORD=$(kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode)
echo "OpenFaaS admin password: $PASSWORD"
```
