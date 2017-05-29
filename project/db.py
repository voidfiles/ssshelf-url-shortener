from pymongo import MongoClient
from pymongo.errors import DuplicateKeyError

client = MongoClient('localhost', 27017)
db = client.urls_db
urls = db.urls


def get_next_sequence(name):
    ret = db.counters.find_and_modify(
        {'_id': name}, update={'$inc': {'seq': 1}}, new=True)
    return ret['seq']
