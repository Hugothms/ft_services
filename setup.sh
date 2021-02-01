echo "Cleaning Minikube..."
minikube delete

#Detect the platform
OS="`uname`"
echo "Starting Minikube..."
#Change settings depending on the platform
case $OS in
		"Linux")
			minikube start --vm-driver=docker #--extra-config=apiserver.service-node-port-range=1-35000
			CLUSTER_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/yaml/metallb-configmap.yaml
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/nginx/nginx.conf
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/mysql/wordpress.sql
		;;
		"Darwin")
			minikube start --driver=virtualbox #--extra-config=apiserver.service-node-port-range=1-35000
			CLUSTER_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/yaml/metallb-configmap.yaml
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/nginx/nginx.conf
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" srcs/mysql/wordpress.sql
		;;
		*) ;;
esac

echo "Minikube IP: ${CLUSTER_IP}"
eval $(minikube docker-env)

echo "Enabling addons..."
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb

echo "Launching dashboard..."
minikube dashboard &

echo "MetalLB Config"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/yaml/metallb-configmap.yaml

echo "Creating Persistent Volumes"
kubectl apply -f srcs/yaml/mysqlvol.yaml
kubectl apply -f srcs/yaml/influxdbvol.yaml

echo "Building Images"
docker build -t nginx_i srcs/nginx/.
docker build -t mysql_i srcs/mysql/.
docker build -t phpmyadmin_i srcs/phpmyadmin/.
docker build -t wordpress_i srcs/wordpress/.
docker build -t service_ftps --build-arg IP=${CLUSTER_IP} srcs/ftps
docker build -t influxdb_i srcs/influxdb/.
docker build -t grafana_i srcs/grafana/.

echo "Creating pods and services..."
kubectl apply -f srcs/yaml/ftps.yaml
kubectl apply -f srcs/yaml/mysql.yaml
kubectl apply -f srcs/yaml/nginx.yaml
kubectl apply -f srcs/yaml/grafana.yaml
kubectl apply -f srcs/yaml/influxdb.yaml
kubectl apply -f srcs/yaml/phpmyadmin.yaml
kubectl apply -f srcs/yaml/wordpress.yaml

kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/mysql/wordpress.sql
case $OS in
		"Linux")
			sed -i "s/"192.168.49.2"/"$CLUSTER_IP"/g" ./setup.sh
		;;
		"Darwin")
			sed -i '' "s/"192.168.49.2"/"$CLUSTER_IP"/g" ./setup.sh
		;;
		*) ;;
	esac
