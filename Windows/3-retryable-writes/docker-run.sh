#!/usr/bin/env bash

docker run -h mongodb-nightclazz --rm --name mongodb-nightclazz-app --network netnightclazz --network-alias nightclazz-mongo ptijohn/mongodb-nightclazz-app:1.0

