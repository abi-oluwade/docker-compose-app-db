# Sparta Node Sample App

This is using docker compose to create two containers that are linked via the environmental variables in the Dockerfile
that connects the app container to the mongo container.

````
ENV DB_HOST=mongodb://mongo:27017/posts
````
The above line in the Dockerfile uses 'mongo' instead of localhost as it is not trying to connect to the localhost machine
but rather the container named 'mongo' which was specified in the docker compose.

When creating the Jenkins ci pipeline, I have emailed to abi.oluwade@gmail.com the instructions to create a slave node, and also to sort out the git SCM you must add the deploy key and have the corresponding private key in your credentials on the Jenkins server.

*Restrict where this project can run* in the GENERAL section on Jenkins config allows us to pick
a node or slave for the job to be carried out on.

================================================================================
# Docker instructions for app and apache2 and Jenkins


````
- To build the container use "docker build .\app-apache\ -t abioluwade/app-apache-1"

- To run the container simply use "docker run -p 80:3000  -i -t abioluwade/app-apache-1"

````

This is the repo URL for this container: https://hub.docker.com/repository/docker/abioluwade/app-apache-2/general

And can be pulled with: docker pull abioluwade/app-apache-1:latest

This is the syntax to push it to my repo: docker login ; docker push abioluwade/app-apache-1

NOTE: It is important to start all tags with "abioluwade/" when building if I want
to push it to the repo later.


NOTE: provision script must be modified slightly as the paths in a docker container
are slightly different to the paths in my vagrant dev environment.


================================================================================

First things first lets Download the 'cloudbees build and publish' plugin which will allow us the run the image within
a docker container on the slave node specified that has the testing environment.

````
docker login;
````
first step is to do this and give the docker hub credentials

Using Jenkins master and slave nodes I will try to test the repo using webhooks
and then proceed to deploy the image to that it can be accessed publicly.

````
sudo docker run -it -p 80:3000 -v /var/run/docker.sock:/var/run/docker.sock abioluwade/app-apache-1
````
- This command will run the image with port 80 on the machine mapped to port 3000 within the container which
the app is running on. (-d can run it in detached mode and allow the user to perform other tasks on the computer while
  the container continues to run)

````
sudo chown jenkinsproduction:jenkinsproduction /home/jenkinsproduction/.docker -R
sudo chmod g+rwx "/home/jenkinsslave/.docker" -R

````
Login and logout for the above to take effect. (jenkinsslave is the name of the user in this instance)

````
sudo chmod 777 /var/run/docker.sock
````

to change the permissions so docker daemon can be accessed via Jenkins

- Exit after changing these permissions then ssh in again.

So the CI pipeline will listen to the repo, and then test any changes by building from the Dockerfile in the repo
if this successfully builds, the next step which is CD will start and deploy the image onto the production server.

================================================================================

This side project was to simulate a *dev* environment being able to run a docker image and play around with it within a container
a *test* environment with docker installed and lets the Dockerfile be built there that was modified by the dev, and
a production *env* which is where the CD jenkins job deploys the app to the public.

================================================================================

When creating the Jenkins ci pipeline, I have emailed to abi.oluwade@gmail.com the instructions to create a slave node, and also to sort out the git SCM you must add the deploy key and have the corresponding private key in your credentials on the Jenkins server.

*Restrict where this project can run* in the GENERAL section on Jenkins config allows us to pick
a node or slave for the job to be carried out on.


TEST JENKINS WEBHOOK


================================================================================




````
cd jenkinsproduction/home/workspace
docker build docker-app-cd -t abioluwade/app-apache-3:latest
docker push abioluwade/app-apache-3:latest
````
 Try and get this logic to work.



========================================================================================================================================================================================================


## Description

This app is intended for use with the Sparta Global Devops Stream as a sample app. You can clone the repo and use it as is but no changes will be accepted on this branch.

To use the repo within your course you should fork it.

The app is a node app with three pages.

### Homepage

``localhost:3000``

Displays a simple homepage displaying a Sparta logo and message. This page should return a 200 response.

### Blog

``localhost:3000/posts``

This page displays a logo and 100 randomly generated blog posts. The posts are generated during the seeding step.

This page and the seeding is only accessible when a database is available and the DB_HOST environment variable has been set with it's location.

### A fibonacci number generator

``localhost:3000/fibonacci/{index}``

This page has be implemented poorly on purpose to produce a slow running function. This can be used for performance testing and crash recovery testing.

The higher the fibonacci number requested the longer the request will take. A very large number can crash or block the process.


### Hackable code

``localhost:3000/hack/{code}``

There is a commented route that opens a serious security vulnerability. This should only be enabled when looking at user security and then disabled immediately afterwards

## Usage

Clone the app

```
npm install
npm start
```

You can then access the app on port 3000 at one of the urls given above.

## Tests

There is a basic test framework available that uses the Mocha/Chai framework

```
npm test
```

The test for posts will fail ( as expected ) if the database has not been correctly setup.
