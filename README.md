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
