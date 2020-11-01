#!/bin/sh -x
if [ $1 = 'full' ]
then
	brew install kubectl
	brew install minikube
fi
sh ~hthomas/42/42toolbox/init_docker.sh
sleep 60
minikube config set vm-driver virtualbox
minikube delete
docker-machine create --driver virtualbox default
docker-machine start
