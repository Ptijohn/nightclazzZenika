#!/usr/bin/env bash
docker stop mongodb-nightclazz
docker rm -v mongodb-nightclazz
rm -rf data 
