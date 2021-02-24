services="nginx ftps grafana mysql influxdb wordpress"
OS="`uname`"

start_minikube()
{
	minikube start --vm-driver=docker #--extra-config=apiserver.service-node-port-range=1-35000
	CLUSTER_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
	#Change settings depending on the platform
	case $OS in
		"Linux")
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/yaml/metallb-configmap.yaml
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/nginx/nginx.conf
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/mysql/wordpress.sql
		;;
		"Darwin")
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/yaml/metallb-configmap.yaml
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/nginx/nginx.conf
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/mysql/wordpress.sql
		;;
	));;
	esac
	# echo "Minikube IP: ${CLUSTER_IP}"
	eval $(minikube docker-env)

	# echo "Enabling addons..."
	minikube addons enable metrics-server
	minikube addons enable dashboard
	minikube addons enable metallb

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
	if [ $1 = "ftps" ]
	then
		docker build -t service_$1 srcs/$1 --build-arg IP=${CLUSTER_IP}
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
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" ./setup.sh
		;;
		"Darwin")
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" ./setup.sh
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

restart()
{
	if [ $1 = "" ]
	then
		printf "\n\e[33;1m restart: '$1': no such service!\n\e[0m"
	else
		kubectl delete -f srcs/yaml/$1.yaml
		start_service $1
	fi
}

delete()
{
	minikube delete
}

if [ $1 = "start" ] || [ $1 = "" ]
then
	start
elif [ $1 = "restart" ]
then
	restart $2
elif [ $1 = "delete" ]
then
	delete $2
fi
