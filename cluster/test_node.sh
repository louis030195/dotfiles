#!/bin/bash

# This is a script that run a hello world pod on a specific node of a Kuberenetes cluster
# to test if the connection to the cluster is working.

set -e

# trap ctrl-c and call ctrl_c()
trap clean_up INT

function clean_up() {
  echo "Cleaning up..."
  kubectl delete pod hello-world && exit 0
}

# Ask the user the node hostname to use and write it to NODE_NAME variable
read -p "What node hostname do you want to use? " NODE_NAME

# Ask the user if it's a gpu node and check if it works
read -p "Is this a gpu node? [y/N] " IS_GPU

IMAGE="hello-world"
NB_GPU="0"
# if GPU use nvidia/cuda:11.4.1-base-ubuntu20.04
if [ "$IS_GPU" = "y" ]; then
  IMAGE="nvidia/cuda:11.4.1-base-ubuntu20.04"
  NB_GPU="1"
fi

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  namespace: default
spec:
    containers:
    - name: hello-world
      image: ${IMAGE}
      command: [ "/bin/bash", "-c", "--" ]
      args: [ "while true; do sleep 30; done;" ]
      resources:
        limits:
          nvidia.com/gpu: ${NB_GPU}
    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
          - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
              - ${NODE_NAME}
EOF

echo "Waiting for pod to be ready..."

# Wait for the pod to be running
OK=$(kubectl wait --for=condition=Ready pod/hello-world --timeout=120s || true)
if [ "$OK" != "pod/hello-world condition met" ]; then
  echo "Pod is not running"
  kubectl logs --previous pod/hello-world
  clean_up
  exit 1
fi

# If it's a GPU node, let's run nvidia-smi to check if the GPU is working
if [ "$IS_GPU" = "y" ]; then
  echo "Running nvidia-smi..."
  kubectl exec -it hello-world -- nvidia-smi
  echo "Done!"
fi

echo "Pod is running!"

# clean up
clean_up

echo "Test node script finished"


