#!/usr/bin/env bash

# Here we start our main MongoDB instance, in >3.6

docker run -d -p 27017:27017 -h mongodb-nightclazz1 --network netnightclazz --network-alias nightclazz-mongo1 --name mongodb-nightclazz1 mongo:3.6.1 --port=27017 --replSet myReplica --bind_ip_all

docker run -d -p 27018:27018 -h mongodb-nightclazz2 --network netnightclazz --network-alias nightclazz-mongo2 --name mongodb-nightclazz2 mongo:3.6.1 --port=27018 --replSet myReplica --bind_ip_all

docker run -d -p 27019:27019 -h mongodb-nightclazz3 --network netnightclazz --network-alias nightclazz-mongo3 --name mongodb-nightclazz3 mongo:3.6.1 --port=27019 --replSet myReplica --bind_ip_all

# Here we initialize the replica

docker exec mongodb-nightclazz1 mongo --eval 'rs.initiate()'
docker exec mongodb-nightclazz1 mongo --eval 'rs.add("nightclazz-mongo1:27017")'
docker exec mongodb-nightclazz1 mongo --eval 'rs.add("nightclazz-mongo2:27018")'
docker exec mongodb-nightclazz1 mongo --eval 'rs.addArb("nightclazz-mongo3:27019")'

docker exec mongodb-nightclazz1 mongo --eval 'db.adminCommand( { setFeatureCompatibilityVersion: "3.6" } )'

