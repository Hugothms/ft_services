#!/bin/sh -x

# ! Minikube and dashboard start
minikube start --driver=virtualbox
gnome-terminal -- minikube dashboard
minikube status
kubectl version

# kubectl get service
# kubectl get nodes
# kubectl get deployments
# kubectl get pods

# ! Nginx
docker build -t nginx srcs/nginx
kubectl apply -f srcs/nginx/deployment.yaml
#kubectl describe deployment nginx-deployment

# ! MySQL
docker build -t mysql srcs/mysql
kubectl apply -f srcs/mysql/deployment.yaml
#kubectl describe deployment mysql-deployment


# kubectl apply -f srcs/service.yaml
# kubectl apply -f srcs/ingress.yaml

# kubectl get service
# kubectl get nodes
# kubectl get deployments
# kubectl get pods
