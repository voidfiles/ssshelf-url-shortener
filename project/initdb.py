from .db import db

db.counters.insert({
    "_id": "userid",
    "seq": 0
})

db.urls.create_index([("url", 1)], unique=True)
