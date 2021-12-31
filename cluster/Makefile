

k3s_install:
	export K3S_NODE_NAME=${HOSTNAME//_/-}
	export K3S_EXTERNAL_IP=$(curl ifconfig.me 2>/dev/null)
	export INSTALL_K3S_EXEC="--docker --write-kubeconfig ~/.kube/kubeconfig.yml --write-kubeconfig-mode 666 --advertise-address ${K3S_EXTERNAL_IP} --tls-san ${K3S_EXTERNAL_IP} --node-external-ip=${K3S_EXTERNAL_IP} --kube-apiserver-arg external-hostname=${K3S_EXTERNAL_IP}"
	curl -sfL https://get.k3s.io |  sh -

	sudo mkdir -p /etc/rancher/k3s
	sudo cp k3s.yml /etc/rancher/k3s/config.yaml
	curl -sfL https://get.k3s.io | sh -
	# watch kubectl get all -A
	# sudo cat /var/lib/rancher/k3s/server/node-token

k3s_uninstall:
	/usr/local/bin/k3s-uninstall.sh
