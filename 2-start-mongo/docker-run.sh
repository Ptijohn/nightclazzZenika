#!/usr/bin/env bash

mkdir -p data

# Here we start our main MongoDB instance, in >3.6
docker run -d -p 27017:27017 -v $(pwd)/data:/data/db -u 1000:1000 -h mongodb-nightclazz --network netnightclazz --network-alias nightclazz-mongo --name mongodb-nightclazz mongo:3.6.1 --port=27017 --bind_ip_all --logpath /data/db/mongod.log

