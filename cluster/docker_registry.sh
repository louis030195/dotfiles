#!/bin/bash

# This is a script that setup a kubernetes cluster to use a Cloud docker registry.

set -e

trap clean_up INT

function clean_up() {
  echo "Cleaning up..."
  # Delete in given namespace if "NAMESPACE" is set or fail with error
  kubectl delete pod hello-world -n ${NAMESPACE}
  exit 1
}


# Ask which Cloud provider you want to use (Google or OVHcloud)
echo "Which Cloud provider you want to use (google or ovh)?"
read -p "Enter your choice: " cloud_provider

# If "google"
if [ "$cloud_provider" == "google" ]; then
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

# else if "ovh"
elif [ "$cloud_provider" == "ovh" ]; then
  # Ask project id
  read -p "Enter your project id: " PROJECT_ID
else
  echo "You have to choose between google or ovh"
  exit 1
fi


SECRET_NAME="${PROJECT_ID}-registry"
# Ask the user the namespace to use and write it to NAMESPACE variable
read -p "What namespace do you want to use? " NAMESPACE

# Create the namespace if it does not exist
kubectl get namespace ${NAMESPACE} || (echo "Creating namespace ${NAMESPACE}" && kubectl create namespace ${NAMESPACE})

# Ask the user the docker username and password
# The password is either a simple one or within a service account file
# i.e. cat the user-given file
read -p "What is the docker username? " DOCKER_USERNAME
read -p "What is the docker password? You can either type it or provide a file (i.e. GCP service account): " DOCKER_PASSWORD
# Ask docker server
read -p "What is the docker server? " DOCKER_SERVER
# Ask docker email
read -p "What is the docker email? " DOCKER_EMAIL
# If docker password sounds like a file (ends in .json), read it
if [[ $DOCKER_PASSWORD == *.json ]]; then
    DOCKER_PASSWORD=$(cat $DOCKER_PASSWORD)
fi

kubectl create secret docker-registry ${SECRET_NAME} \
  --docker-server=${DOCKER_SERVER} \
  --docker-username=${DOCKER_USERNAME} \
  --docker-password=${DOCKER_PASSWORD} \
  --docker-email=${DOCKER_EMAIL} \
  -n=${NAMESPACE} || (echo "Secret already exists" && kubectl get secret ${SECRET_NAME} -n ${NAMESPACE})

kubectl patch serviceaccount default \
  -p "{\"imagePullSecrets\": [{\"name\": \"${SECRET_NAME}\"}]}" \
  --namespace=${NAMESPACE}

echo " You can now use the secret ${SECRET_NAME} to pull images from this registry"

# Test the registry
# Push a basic image to the registry
echo "Pushing a basic image to the registry ${DOCKER_SERVER}/${PROJECT_ID}/hello-world"
docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_SERVER}
docker tag hello-world ${DOCKER_SERVER}/${PROJECT_ID}/hello-world
docker push ${DOCKER_SERVER}/${PROJECT_ID}/hello-world || (echo "Docker push failed, make sure the user has the right permissions" && exit 1)

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
    image: ${DOCKER_SERVER}/${PROJECT_ID}/hello-world
    command: [ "/bin/bash", "-c", "--" ]
    args: [ "while true; do sleep 30; done;" ]
EOF

# Wait for the pod to be running
OK=$(kubectl wait --for=condition=Ready pod/hello-world -n ${NAMESPACE} --timeout=120s || true)
if [ "$OK" != "pod/hello-world condition met" ]; then
  echo "Pod is not running"
  kubectl logs --previous pod/hello-world -n ${NAMESPACE}
  clean_up
  exit 1
fi

echo "Done"

# Cleanup pod
clean_up

# Show secret
kubectl get secret ${SECRET_NAME} --namespace=${NAMESPACE}
