#!/usr/bin/env bash

docker run -h mongodb-nightclazz --name mongodb-nightclazz-app --network netnightclazz --network-alias nightclazz-mongo ptijohn/mongodb-nightclazz-app:1.0

