from pymongo import MongoClient
from pymongo import ReadPreference
from pymongo.errors import WriteConcernError

# Connection to the database
client = MongoClient(host=['nightclazz-mongo1:27017','nightclazz-mongo2:27018'],replicaset='myReplica')

# Read from primary, to see state
doc = client.test.testCausal.find_one({'_id': 1})
print(doc)

with client.start_session(causal_consistency=False) as session:
#with client.start_session(causal_consistency=True) as session:
    collection = client.test.testCausal
    collection.update_one({'_id': 1},{'$inc':{'x' : 10}}, upsert=True, session=session)
    secondary_c = collection.with_options(
        read_preference=ReadPreference.SECONDARY)

    # A secondary read waits for replication of the write.
    doc = secondary_c.find_one({'_id': 1}, session=session)
    print(doc)


