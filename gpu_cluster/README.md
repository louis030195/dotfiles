# k3s-gpu

K3s container rebuild for K3d with NVIDIA GPU support  
  
To start a K3d cluster with all gpus used execute:  

```
export CLUSTER_NAME=basic && \
k3d cluster create $CLUSTER_NAME --config ./k3d_config.yaml && \
k3d kubeconfig write $CLUSTER_NAME && \
export KUBECONFIG=$HOME/.k3d/kubeconfig-$CLUSTER_NAME.yaml
```

References:  
https://k3d.io/usage/guides/cuda/  
https://github.com/rancher/k3d  
  
Bonus:  

[Gitlab Runner with Docker TLS on K3d](gitlab-runner/README.md)

