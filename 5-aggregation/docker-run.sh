#/usr/bin/env bash

echo "Creating hidden files"
touch "$(pwd)/.dbshell"
touch "$(pwd)/.mongorc.js"
echo "Sending them to docker"
docker cp "$(pwd)/.dbshell" mongodb-nightclazz1:/.dbshell
docker cp "$(pwd)/.dbshell" mongodb-nightclazz1:/.mongorc.js
echo "Sending json files to docker"
docker cp "$(pwd)/arrayToObject.json" mongodb-nightclazz1:/arrayToObject.json
docker cp "$(pwd)/objectToArray.json" mongodb-nightclazz1:/objectToArray.json
echo "Importing the files into MongoDB"
docker exec -t mongodb-nightclazz1 mongoimport --host 'myReplica/localhost:27017,nightclazz-mongo2:27018' --drop -d test -c arrayToObject /arrayToObject.json
docker exec -t mongodb-nightclazz1 mongoimport --host 'myReplica/localhost:27017,nightclazz-mongo2:27018' --drop -d test -c objectToArray /objectToArray.json
echo "Done"



