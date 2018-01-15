#/usr/bin/env bash

docker cp "$(pwd)/tododb.json" mongodb-nightclazz1:/tododb.json
docker exec -t mongodb-nightclazz1 mongoimport --host 'myReplica/nightclazz-mongo1:27017,nightclazz-mongo2:27018' --drop -d tododb -c tododb /tododb.json
