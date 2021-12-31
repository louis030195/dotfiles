#!/bin/bash

# This is a script that run a hello world pod on a specific node of a Kuberenetes cluster
# to test if the connection to the cluster is working.

set -ex

# Ask the user the node hostname to use and write it to NODE_NAME variable
read -p "What node hostname do you want to use? " NODE_NAME

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  namespace: default
spec:
    containers:
    - name: hello-world
      image: hello-world
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