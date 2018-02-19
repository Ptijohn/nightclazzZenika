# Zenika Nightclazz - Testing MongoDB 3.6 new features

This repository consists in a bunch of scripts to execute to test new MongoDB 3.6 features.

# Prerequities

 * Linux
 * Docker
 * Aaaaaand, that's all folks

# Knowledge necessary

 * Basic Docker (you can do without this)
 * Basic MongoDB
 * Basic Python

# For Windows (and possibly OSX)

Go to the Windows folder and check the README. 

# How to Use

## Creating the network

 * Go to 1-network and execute `create.sh`
 * If need be, you can remove the network by using `clean.sh`

## Creating the MongoDB Database

 * Go to 2-start-mongo and execute `docker-run.sh`
 * If need be, you can use `docker-clean.sh` to totally erase the MongoDB instances (beware, you'll lose Data if you do that)
 * Please note the setFeatureCompatibilityVersion fixed to 3.6, it allows us to test the retryable Writes.

## Testing retryable write

 * Go to 3-retryable-writes and look at the script `hereWeCode.py`, it writes to MongoDB, using retryWrites = true, and w:2 for writeConcern (it slows down the script, making it easier for us to make it crash :D)
 * Build the image with `docker-build.sh`
 * In another terminal, go to mongo using `docker exec -it mongodb-nightclazz1 mongo`
 * Return to your original terminal and execute your code with `docker-run.sh`
 * Go to the mongo terminal, and type `rs.stepDown()`, which is going to make the PRIMARY step down, creating a potential problem.
 * Except your `docker-run.sh` won't have crashed, and will keep writing as soon as a new PRIMARY is elected.
 * To try and make it crash, please edit hereWeCode.py, and pass the retryWrites to False. And do again the above sequence, starting with a `docker-clean.sh` first.
 * To clean the database and put the PRIMARY back to its previous state, go to `docker exec -it mongodb-nightclazz2 mongo --port 27018` and do `db.test.drop()` followed by `rs.stepDown()`.

## Testinig causal consistency

 * Go to 4-causal-consistency and look at the script `hereWeCode.py`, it reads from MongoDB, without option, to get the actual state of data
 * It then opens a session, updates the document that we just read (or inserts if the document didn't exist)
 * It then reads the document we just upserted (with readPreference to 'secondary').
 * Put causalConsistency to False to test things out.
 * Build the image with `docker-build.sh`
 * Run the script with `docker-run.sh` (Don't hesitate to run it multiple times). You'll see that there's no difference between the first and the second print, despite the update
 * Put causalConsistency to True.
 * Build the image with `docker-build.sh`
 * Run the script with `docker-run.sh` (Don't hesitate to run it multiple times). Now the two prints will be different, as the session is waiting for replication. 
 * NOTE : In this case, putting the write concern to 2 would have also worked.

## Trying aggregation stages

### Array to Object
 * Use the `docker-run.sh` to load some data in MongoDB
 * Use `connect_to_mongodb.sh` to launch the shell
 * Launch this command to test `$arrayToObject`:
```javascript
db.arrayToObject.aggregate(
   [
      {
         $project: {
            item: 1,
            dimensions: { $arrayToObject: "$dimensions" }
         }
      }
   ]
)
```
 * Launch this command to test `$objectToArray`:
```javascript
db.objectToArray.aggregate(
   [
      {
         $project: {
            item: 1,
            dimensions: { $objectToArray: "$dimensions" }
         }
      }
   ]
)
```

