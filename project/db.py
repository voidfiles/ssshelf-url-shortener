import json
import os

import simpleflake

from ssshelf.items import IManager
from ssshelf.utils import json_dump
from ssshelf.storages.s3 import S3Storage
from ssshelf.storages.cached import ReadKeyCacheInMemory
from ssshelf.keys import encode_int_as_str


def create_url(url):
    return {
        'url': url,
        'pk': encode_int_as_str(int(simpleflake.simpleflake())),
    }


class ShortURL(IManager):
    def get_pk(self, item):
        return item.get('pk')

    def serialize_item(self, item):
        return bytes(json_dump(item), 'utf8')

    def deserialize_item(self, data):
        return json.loads(data)

short_url_manager = ShortURL(
    storage=ReadKeyCacheInMemory(S3Storage(bucket=os.environ.get('AWS_BUCKET')))
)
