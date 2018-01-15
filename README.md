# Zenika Nightclazz

This repository is made for zenika nightclazz, a bunch of scripts to execute to test new MongoDB 3.6 features

# How to Use

## Creating the network

 * Go to 1-network and execute create.sh
 * If need be, you can remove the network by using the clean.sh

## Creating the MongoDB Database

 * Go to 2-start-mongo and execute docker-run.sh
 * If need be, you can use docker-clean.sh to totally erase the MongoDB instance (beware, you'll lose Data if you do that)

## Getting some stuff into MongoDB

 * Go to 3-init-data and execute docker-run.sh
 * Note the --drop in the command line, it drops the collection before inserting the data, allowing you to start from scratch easily

## Getting to the core of our exercise

 * Go to 4-lets-code and look at the script hereWeCode.py, that's where you'll code
 * Once the coding is done, build the image with docker-build.sh
 * Execute your code with docker-run.sh


