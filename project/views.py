import json
import asyncio
from apistar import http, Response
from apistar.interfaces import Router
from project.db import short_url_manager, create_url

base_url = "https://afternoon-lowlands-76627.herokuapp.com/"

loop = asyncio.get_event_loop()


async def new(body: http.Body, router: Router, request: http.Request):
    data = json.loads(body)
    url_data = create_url(data.get('url'))

    await short_url_manager.add_item(url_data)

    base_url = 'http://%s' % (request.headers['host'])
    base_url += router.reverse_url('redirect', {'short_url': url_data.get('pk')})

    return {
        "original_url": url_data.get('url'),
        "short_url": base_url,
    }


async def redirect(short_url) -> Response:
    url_data = await short_url_manager.get_item(short_url)
    if not url_data:
        resp = {
            "error": "This url is not on the database."
        }

        return Response(resp, status=404, headers={})

    headers = {'Location': url_data['url']}

    return Response(None, status=302, headers=headers)
