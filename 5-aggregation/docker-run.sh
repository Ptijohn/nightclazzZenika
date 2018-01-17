#/usr/bin/env bash

docker cp "$(pwd)/arrayToObject.json" mongodb-nightclazz1:/arrayToObject.json
docker exec -t mongodb-nightclazz1 mongoimport --host 'myReplica/nightclazz-mongo1:27017,nightclazz-mongo2:27018' --drop -d test -c arrayToObject /arrayToObject.json



