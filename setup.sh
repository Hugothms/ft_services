services="influxdb nginx mysql phpmyadmin wordpress grafana ftps"
OS="`uname`"

is_a_service()
{
	if [ "$#" -eq 0  ]; then
			echo 0
			exit
	fi
	for service in $services
	do
		if [ $service = $1 ]; then
			echo 1
			exit
		fi
	done
	echo 2
}

init()
{
	if [ $1 = 'full' ]; then
		brew install kubectl
		brew install minikube
	fi
	sh ~hthomas/42/42toolbox/init_docker.sh
	sleep 60
	minikube config set vm-driver virtualbox
	minikube delete
	docker-machine create --driver virtualbox default
	docker-machine start
}

start_minikube()
{
	minikube start --vm-driver=docker #--extra-config=apiserver.service-node-port-range=1-35000
	CLUSTER_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
	#Change settings depending on the platform
	case $OS in
		"Linux")
			sed -i "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/yaml/metallb-configmap.yaml
			sed -i "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/nginx/nginx.conf
			sed -i "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/mysql/wordpress.sql
			sed -i "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/ftps/Dockerfile
		;;
		"Darwin")
			sed -i '' "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/yaml/metallb-configmap.yaml
			sed -i '' "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/nginx/nginx.conf
			sed -i '' "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/mysql/wordpress.sql
			sed -i '' "s/"172.17.0.2"/"$CLUSTER_IP"/g" srcs/ftps/Dockerfile
		;;
	));;
	esac
	# echo "Minikube IP: ${CLUSTER_IP}"

	# echo "Enabling addons..."
	minikube addons enable metrics-server
	minikube addons enable metallb
	minikube addons enable dashboard

	# echo "Launching dashboard..."
	minikube dashboard &

	# echo "MetalLB Config"
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f srcs/yaml/metallb-configmap.yaml

	# echo "Creating Persistent Volumes"
	kubectl apply -f srcs/yaml/mysqlvol.yaml
	kubectl apply -f srcs/yaml/influxdbvol.yaml
	
	eval $(minikube docker-env)
}


build_docker_image()
{
	docker build -t $1_i srcs/$1/.
}

apply_yaml()
{
	kubectl apply -f srcs/yaml/$1.yaml
}

start_service()
{
	if [ $1 = "ftps" ]; then
		docker build -t $1_i srcs/$1 --build-arg IP=${CLUSTER_IP}
	else
		build_docker_image $1
	fi
	apply_yaml $1
}

start_services()
{
	for service in $services
	do
		start_service $service
	done
}

start_end()
{
	#Initialize database
	kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/mysql/wordpress.sql

	CLUSTER_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
	case $OS in
		"Linux")
			sed -i "s/"172.17.0.2"/"$CLUSTER_IP"/g" ./setup.sh
		;;
		"Darwin")
			sed -i '' "s/"172.17.0.2"/"$CLUSTER_IP"/g" ./setup.sh
		;;
	*);;
	esac
}

start()
{
	start_minikube
	start_services
	start_end
}

delete_all()
{
	kubectl delete --all ingresses
	kubectl delete --all deployments
	kubectl delete --all pods
	kubectl delete --all services
	kubectl delete --all pvc
	kubectl delete namespaces metallb-system
	minikube stop
	docker rmi $(docker images -a -q)
	docker system prune -f
}

delete()
{
	if [ "$#" -eq 0 ]; then
		minikube delete
	elif [ $1 = "all" ]; then
		delete_all
	else
		minikube delete
	fi
}

restart()
{
	if [ "$#" -eq 0 ]; then
		delete
		start
	elif [ $(is_a_service $1) = 1 ]; then
		kubectl delete -f srcs/yaml/$1.yaml
		start_service $1
	else
		printf "Not such service: %s\n" $1
	fi
}

if [ "$#" -eq 0 ]; then
	restart
elif [ $1 = "start" ]; then
	start
elif [ $1 = "delete" ]; then
	delete $2
else
	restart $2
fi
