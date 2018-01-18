#!/usr/bin/env bash

docker run -h mongodb-nightclazz --rm --name mongodb-nightclazz-causal --network netnightclazz --network-alias nightclazz-mongo ptijohn/mongodb-nightclazz-causal:1.0

