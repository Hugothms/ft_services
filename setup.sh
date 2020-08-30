#!/bin/sh -x

# ! Minikube and dashboard start
kubectl config use-context minikube
minikube start --driver=docker
minikube addons enable metallb
eval $(minikube -p minikube docker-env)
gnome-terminal -- minikube dashboard
minikube dashboard &

echo "Eval..."
eval $(minikube docker-env)
# minikube status
# kubectl version

# ! MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/configmap.yaml

# ! Nginx
docker build -t my_nginx srcs/nginx
# docker images
kubectl apply -f srcs/nginx/deployment.yaml
kubectl expose deploy nginx --port=80 --type=LoadBalancer
kubectl apply -f srcs/nginx/service.yaml
# kubectl describe deployment nginx

# ! MySQL
docker build -t my_mysql srcs/mysql
kubectl apply -f srcs/mysql/deployment.yaml
#kubectl describe deployment mysql

# ! Wordpress
# docker build -t my_wordpress srcs/wordpress
# kubectl apply -f srcs/wordpress/deployment.yaml
# kubectl describe deployment wordpress

# kubectl apply -f srcs/ingress.yaml

# kubectl get service
# kubectl get nodes
# kubectl get deployments
# kubectl get pods
# kubectl get all


