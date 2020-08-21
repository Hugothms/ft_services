#!/bin/sh -x

# ! Minikube and dashboard start
minikube start --driver=docker
minikube addons enable metallb
eval $(minikube -p minikube docker-env)
gnome-terminal -- minikube dashboard
# minikube status
# kubectl version

# ! MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/configmap.yaml

# ! Nginx
docker build -t nginx srcs/nginx
kubectl apply -f srcs/nginx/deployment.yaml
kubectl expose deploy nginx-deployment --port=80 --type=LoadBalancer
# kubectl describe deployment nginx

# ! MySQL
docker build -t mysql srcs/mysql
kubectl apply -f srcs/mysql/deployment.yaml
#kubectl describe deployment mysql-deployment

# ! Wordpress
docker build -t wordpress srcs/wordpress
kubectl apply -f srcs/wordpress/deployment.yaml
# kubectl describe deployment wordpress-deployment

# kubectl apply -f srcs/service.yaml
# kubectl apply -f srcs/ingress.yaml

# kubectl get service
# kubectl get nodes
# kubectl get deployments
# kubectl get pods
# kubectl get all
