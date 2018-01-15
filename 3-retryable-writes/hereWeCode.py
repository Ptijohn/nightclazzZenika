from pymongo import MongoClient
from pymongo.errors import WriteConcernError

# Connection to the database
client = MongoClient(host=['nightclazz-mongo1:27017','nightclazz-mongo2:27018'],replicaset='myReplica',retryWrites=True,w=2)
#client = MongoClient(host=['nightclazz-mongo1:27017','nightclazz-mongo2:27018'],replicaset='myReplica',retryWrites=False,w=2)
db = client.test

for i in range(1500):
	try: 
		db.test.insert_one({'a':i})
	except WriteConcernError:
		print "Exception thrown, what do we do?"

