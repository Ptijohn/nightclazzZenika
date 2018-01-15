#!/usr/bin/env bash

mkdir -p data/{db1,db2,db3}

# Here we start our main MongoDB instance, in >3.6
docker run -d -p 27017:27017 -v $(pwd)/data/db1:/data/db1 \
	-u 1000:1000 -h mongodb-nightclazz1 --network netnightclazz \
	--network-alias nightclazz-mongo1 --name mongodb-nightclazz1 \
	mongo:3.6.1 --port=27017 --dbpath /data/db1 --replSet myReplica --bind_ip_all --logpath /data/db1/mongod.log

docker run -d -p 27018:27018 -v $(pwd)/data/db2:/data/db2 \
	-u 1000:1000 -h mongodb-nightclazz2 --network netnightclazz \
	--network-alias nightclazz-mongo2 --name mongodb-nightclazz2 \
	mongo:3.6.1 --port=27018 --dbpath /data/db2 --replSet myReplica --bind_ip_all --logpath /data/db2/mongod.log

docker run -d -p 27019:27019 -v $(pwd)/data/db3:/data/db3 \
	-u 1000:1000 -h mongodb-nightclazz3 --network netnightclazz \
	--network-alias nightclazz-mongo3 --name mongodb-nightclazz3 \
	mongo:3.6.1 --port=27019 --dbpath /data/db3 --replSet myReplica --bind_ip_all --logpath /data/db3/mongod.log

#sleep 3

# Here we initialize the replica

docker exec -it mongodb-nightclazz1 mongo --eval 'rs.initiate()'
docker exec -it mongodb-nightclazz1 mongo --eval 'rs.add("nightclazz-mongo1:27017")'
docker exec -it mongodb-nightclazz1 mongo --eval 'rs.add("nightclazz-mongo2:27018")'
docker exec -it mongodb-nightclazz1 mongo --eval 'rs.addArb("nightclazz-mongo3:27019")'

