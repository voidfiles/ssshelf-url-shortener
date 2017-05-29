from pymongo import MongoClient
from pymongo.errors import DuplicateKeyError
from os import environ

client = MongoClient(f"mongodb://{environ.get('MONGOUSR')}:{environ.get('MONGOPWD')}@ds157571.mlab.com:57571/urls_db")
db = client.urls_db
urls = db.urls


def get_next_sequence(name):
    ret = db.counters.find_and_modify(
        {'_id': name}, update={'$inc': {'seq': 1}}, new=True)
    return ret['seq']
