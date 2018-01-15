from pymongo import MongoClient

client = MongoClient(host=['nightclazz-mongo:27017'])
db = client.tododb

items = db.tododb.find()

for item in items:
	print item


