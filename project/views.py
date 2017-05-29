from apistar import http, Response
from project.encoder import encoder
from project.db import urls, get_next_sequence

base_url = "https://afternoon-lowlands-76627.herokuapp.com/"


def new(url):
    match = urls.find_one({'url': url})
    if match is not None:
        url_id = match['_id']
    else:
        url_id = urls.insert_one({
            '_id': get_next_sequence("userid"),
            'url': url
        }).inserted_id
    return {
        "original_url": url,
        "short_url": base_url + encoder.encode(int(url_id))
    }


def redirect(short_url) -> Response:
    mongo_id = encoder.decode(short_url)
    long_url = urls.find_one({'_id': mongo_id})
    if long_url is not None:
        headers = {'Location': 'http://' + long_url['url'] + '.com'}
        return Response(None, status=302, headers=headers)
    resp = {
        "error": "This url is not on the database."
    }
    return Response(resp, status=404)
