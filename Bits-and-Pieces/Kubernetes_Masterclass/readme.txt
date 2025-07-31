Simple Python -> Docker container appliacation then using K8s (Kubernetes to orchistrate)


Steps to run.
1: Have Docker app open
2: Navigate in the VS Code Terminal to the app folder
3: Run Docker command to build docker IMAGE -> docker build -t <desired name of container> .                             See Docker's Image Tab
4: Run Docker command to run docker CONTAINER -> docker run -p 5000:5000 <name if container>                             See Docker's Container Tab          Can always port first port value to another port i.e 5050:5000
5. Introduce K8s by adding a deployment.yaml (defines how app runs (replicas, image, ports)) & service.yaml (expose app to outside world) files
6. Ensure minikube installed and running -> minikube start                                                                When started, you should be able to see it in Docker app/Containers
7. Run Kubernetes command -> kubectl apply -f deployment.yaml to apply the deployment file 
8. Run Kubernetes command -> kubectl apply -f serivce.yaml to apply the serivce file 
9. Access app via minikube -> minikube service flask-service
10. Rerun the apply commands if needed
10. Confirm running pods -> kubectl get pods








useful commands:

docker build -t <desired name> .
docker run -p 5000:5000 <name>

docker ps                       - Check for active containers
docker stop <Container ID>      - Stop chosen container

lsof -i :5000
kill <pid>



# ✅ General Setup & Deployment
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl delete deployment flask-app
kubectl apply --dry-run=client -f <file>

# 📡 Cluster & Pod Inspection
kubectl cluster-info
kubectl get pods
kubectl get svc
kubectl get endpoints flask-service
kubectl describe pod <pod-name>
kubectl describe svc flask-service

# 🚦 Image & Pod Troubleshooting
eval $(minikube docker-env)
docker build -t flask-k8s ./app
docker images
kubectl get events
kubectl get pods --show-labels

# 🚀 Accessing Your App
minikube service flask-service
minikube service flask-service --url
kubectl port-forward svc/flask-service 8080:80

# 🔧 Scaling & Auto-Management
kubectl scale deployment flask-app --replicas=5
kubectl autoscale deployment flask-app --cpu-percent=50 --min=2 --max=10
