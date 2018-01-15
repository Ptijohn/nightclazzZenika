from pymongo import MongoClient

# Connection to the database
client = MongoClient(host=['nightclazz-mongo1:27017','nightclazz-mongo2:27018'],replicaset='myReplica')
db = client.tododb

items = db.tododb.find()

for item in items:
	print item


