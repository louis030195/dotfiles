#!/bin/bash
# set -x #echo on

UNAMECHK=`uname`
KIND_PATH="/usr/local/bin"
INTERNAL_IP=""
EXTERNAL_IP=""
K3D_FILE=$(which k3d)

sp="/-\|"
sc=0
spin() {
  printf "\b${sp:sc++:1}"
  ((sc==${#sp})) && sc=0
}
endspin() {
  printf "\r%s\n" "$@"
}

#Host IP Check
if [[ $EXTERNAL_IP == "" ]]; then
	if [[ $UNAMECHK == "Darwin" ]]; then
		INTERNAL_IP=$(ifconfig | grep "inet " | grep -v  "127.0.0.1" | awk -F " " '{print $2}'|head -n1)
	else
		INTERNAL_IP=$(ip a | grep "inet " | grep -v  "127.0.0.1" | awk -F " " '{print $2}'|awk -F "/" '{print $1}'|head -n1)
		EXTERNAL_IP=$(dig @resolver4.opendns.com myip.opendns.com +short)
	fi
fi

echo "I found my external IP: $EXTERNAL_IP and my internal IP: $INTERNAL_IP"

# Install K3d
if [[ -f "$K3D_FILE" ]]; then
  echo "$K3D_FILE exists."
else
  echo "Downloading & Installing k3d"
  curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
fi

# Copy Temporary File
cp k3d.yml internal_ip.yml

# Change API Endpoint
sed -i 's/\"0.0.0.0\"/\"'$INTERNAL_IP'\"/g' internal_ip.yml
sed -i 's/my.host.domain/\"'$EXTERNAL_IP'\"/g' internal_ip.yml

echo "Updated k3d config with my internal IP: $(cat internal_ip.yml), creating k3d cluster now..."

# Create Cluster
k3d cluster create --config internal_ip.yml || echo "failed to start k3d" && exit 1

rm internal_ip.yml

# Check Cluster Ready
echo "Starting K3d Cluster"
until [[ $(kubectl get pods -A -o jsonpath='{range .items[*]}{.status.conditions[?(@.type=="Ready")].status}{"\t"}{.status.containerStatuses[*].name}{"\n"}{end}' | grep traefik | awk -F " " '{print $1}' ) = 'True' ]]; do 
  spin
done
endspin

echo "All Resources Ready State!"

echo "Get my cluster config like this: 'scp louis@louis-gpu:/home/louis/.k3d/kubeconfig-basic.yaml ~/.kube/kubeconfig.yml' then 'vim ~/.kube/kubeconfig.yml' and set the server IP to $EXTERNAL_IP"
