# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY . ./
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/out ./

# Copy your results file
COPY Data/rangers-results.json /app/Data/rangers-results.json

#ENV ASPNETCORE_URLS=http://+:80


EXPOSE 80
ENTRYPOINT ["dotnet", "Rangers.Web.dll"]




# docker build -t rangers-app .
# docker run -p 8080:80 rangers-app


###### Kubernetes / MiniKube Instructions ######

# If using Minikube, you can access the application using the following command to get the URL:
# First create the Docker Image:
# docker build -t rangersapp:local .  
# The push the Docker Image to the minikube environment using:
# minikube image load rangersapp:local
# Then create the deployment and service using:
# kubectl apply -f k8s/deployment.yaml
# kubectl apply -f k8s/service.yaml
# Get the IP and Port using:
# minikube ip   
# Visit http://<minikube-ip>:<NodePort> in your browser to access the application.
# http://<minikube-ip>:30080/results


# To clean up the deployment and service, use:
# kubectl delete -f k8s/deployment.yaml
# kubectl delete -f k8s/service.yaml



# Useful commands:
# minikube stop                   
# minikube delete
# minikube start

# kubectl get pods
# kubectl get services
