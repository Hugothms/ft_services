minikube stop
# kubectl delete deployments --all
# kubectl delete service --all
# kubectl delete namespaces metallb-system
# docker rmi -f my_nginx alpine
docker system prune
# docker rmi $(docker images -a -q)
minikube delete