#/usr/bin/env bash

touch "$(pwd)/.dbshell"
touch "$(pwd)/.mongorc.js"
docker cp "$(pwd)/.dbshell" mongodb-nightclazz1:/.dbshell
docker cp "$(pwd)/.dbshell" mongodb-nightclazz1:/.mongorc.js
docker cp "$(pwd)/arrayToObject.json" mongodb-nightclazz1:/arrayToObject.json
docker cp "$(pwd)/objectToArray.json" mongodb-nightclazz1:/objectToArray.json
docker exec -t mongodb-nightclazz1 mongoimport --host 'myReplica/nightclazz-mongo1:27017,nightclazz-mongo2:27018' --drop -d test -c arrayToObject /arrayToObject.json
docker exec -t mongodb-nightclazz1 mongoimport --host 'myReplica/nightclazz-mongo1:27017,nightclazz-mongo2:27018' --drop -d test -c objectToArray /objectToArray.json



