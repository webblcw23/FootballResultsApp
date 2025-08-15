A slightly more complex IaC file which contains a typical main.tf to create an application with a DB aswell.


Note - ideally the username and password would NOT be stored in the code, but in the Azure keyvault and called from there.

Included in this project is an azure-pipeline.yml file to run as an automated pipelin ein Azure DevOps.


Once files are pulled from source - build and run via Docker. Docker should be open on your machine.

docker build -t iacterraformproj .

docker run -d -p 5000:5000 iacterraformproj

can always run on a diff port ie. 5001:5000

check the application is running and open http://localhost:5000 



Note - 
if address in use, check with: docker ps -a to check all running containers
docker stop <container-id>
docker rm <container-id> to remove
or 
docker container prune to remove all

