#!/bin/sh -x

# service docker start
kubectl config use-context minikube
echo "Starting Minikube..."
if [$1 = 42]
then
	minikube start --driver=virtualbox
else
	minikube start --driver=docker --extra-config=apiserver.service-node-port-range=1-35000
	# eval $(minikube -p minikube docker-env)
	eval $(minikube docker-env)
fi

echo "Enabling addons..."
minikube addons enable metallb
minikube addons enable dashboard

echo "Launching dashboard..."
# gnome-terminal -- minikube dashboard
minikube dashboard &

IP=$(minikube ip)
echo "Minikube IP: ${IP}"

echo "Starting MetalLB"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/configmap.yaml

echo "Building Images"
docker build -t my_nginx		srcs/nginx
docker build -t my_mysql		srcs/mysql
docker build -t my_wordpress	srcs/wordpress

echo "Creating pods and services..."
kubectl create -f ./srcs/
# kubectl expose deploy nginx --port=80 --type=LoadBalancer
# echo "Opening the network in your browser"
# firefox http://$IP

echo "Getting informations"
# docker images
# kubectl get service
# kubectl get nodes
# kubectl get deployments
# kubectl get pods
# kubectl get all
# minikube status
# kubectl version
# kubectl describe deployment nginx

