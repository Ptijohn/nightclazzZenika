# Zenika Nightclazz

This repository is made for zenika nightclazz, a bunch of scripts to execute to test new MongoDB 3.6 features

# How to Use

## Creating the network

 * Go to 1-network and execute create.sh
 * If need be, you can remove the network by using the clean.sh

## Creating the MongoDB Database

 * Go to 2-start-mongo and execute docker-run.sh
 * If need be, you can use docker-clean.sh to totally erase the MongoDB instance (beware, you'll lose Data if you do that)
 * Please note the setFeatureCompatibilityVersion fixed to 3.6, it allows us to test the retryable Writes.

## Trying the retryable write

 * Go to 3-retryable-writes and look at the script hereWeCode.py, it writes to MongoDB, using retryWrites = true, and w:2 for writeConcern (it slows down the script, making it easier for us to make it crash :D)
 * Build the image with docker-build.sh
 * In another terminal, go to mongo using `docker exec -it mongodb-nightclazz1 mongo`
 * Return to your original terminal and execute your code with docker-run.sh
 * Go to the mongo terminal, and type `rs.stepDown()`, which is going to make the PRIMARY step down, creating a potential problem
 * Except your docker-run.sh won't have crashed, and will keep writing as soon as a new PRIMARY is elected.
 * To try and make it crash, please edit hereWeCode.py, and pass the retryWrites to false. And do again the above sequence, starting with a docker-clean.sh first.

## Getting some stuff into MongoDB (optional, no purpose for now)

 * Go to old-init-data and execute docker-run.sh
 * Note the --drop in the command line, it drops the collection before inserting the data, allowing you to start from scratch easily

