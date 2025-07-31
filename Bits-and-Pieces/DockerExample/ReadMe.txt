A simple web application with a frontend and backend.
Includes a DockerFile for each.
This will allow both configuration files (app.jsa and index.html) to run on any machine if the repo is pulled from another machine.

By running the following commands you can get this project/web page running
Ensure Docker is running

docker build -t frontend:local ./frontend
&
docker build -t backend:local ./backend

This will run the frontend and also the backend containters 
Now they are built, let's get them running
Run the following Docker Commands to start them up

docker run -d --name frontend-container -p 8080:80 frontend:local
&
docker run -d --name backend-container -p 3000:3000 backend:local

We can now view the frontend and backend seperatly by navigating to them
http://localhost:8080
&
http://localhost:3000


It may be that these ports are already in use. Check Docker application for the ports
e.g 8081 and 3001 in the most recent test.

Note - if you get an issue noting that the containers are already running, check running containers 
docker ps
and if they are already running, let's stop them and remove them for a clean slate
docker stop frontend-container backend-container
docker rm frontend-container backend-container

Stop the containers once we are done with them by runnign the commands.
docker stop frontend-container backend-container
docker rm frontend-container backend-container