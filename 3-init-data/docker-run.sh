#/usr/bin/env bash

docker cp "$(pwd)/tododb.json" mongodb-nightclazz:/tododb.json
docker exec -t mongodb-nightclazz mongoimport --drop -d tododb -c tododb /tododb.json
