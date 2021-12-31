#!/bin/bash

# This is a script that setup a kubernetes cluster to use GCP docker registry.

set -ex

PROJECT_ID=$(gcloud config get-value project)

# Ask the user if he confirms to go with this project

echo "Current project is $PROJECT_ID"
read -p "Do you want to continue? [y/N] " -n 1 -r

# create a GCP service account; format of account is email address
SA_EMAIL=$(gcloud iam service-accounts --format='value(email)' create k8s-gcr-${PROJECT_ID})
# create the json key file and associate it with the service account
gcloud iam service-accounts keys create k8s-gcr-${PROJECT_ID}.json --iam-account=${SA_EMAIL}
# add the IAM policy binding for the defined project and service account
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member serviceAccount:${SA_EMAIL} --role roles/storage.objectViewer

SECRET_NAME="${PROJECT_ID}-registry"
# Ask the user the namespace to use and write it to NAMESPACE variable
read -p "What namespace do you want to use? " NAMESPACE

# Create the namespace if it does not exist
kubectl get namespace ${NAMESPACE} || echo "Creating namespace ${NAMESPACE}" && kubectl create namespace ${NAMESPACE}

kubectl create secret docker-registry ${SECRET_NAME} \
  --docker-server=https://gcr.io \
  --docker-username=_json_key \
  --docker-email=louis.beaumont@gmail.com \
  --docker-password="$(cat k8s-gcr-${PROJECT_ID}.json)" \
  --namespace=${NAMESPACE}

kubectl patch serviceaccount default \
  -p "{\"imagePullSecrets\": [{\"name\": \"${SECRET_NAME}\"}]}" \
  --namespace=${NAMESPACE}

echo " You can now use the secret ${SECRET_NAME} to pull images from gcr.io"

# Test the registry
# Push a basic image to the registry
docker tag hello-world gcr.io/${PROJECT_ID}/hello-world
docker push gcr.io/${PROJECT_ID}/hello-world

# Then use it in a Pod
cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  namespace: ${NAMESPACE}
spec:
  containers:
  - name: hello-world
    image: gcr.io/${PROJECT_ID}/hello-world
    command: ["/hello"]
EOF

# Check the Pod
kubectl get pods --namespace=${NAMESPACE}

echo "Done"
