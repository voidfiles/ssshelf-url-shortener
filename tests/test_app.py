import json

from apistar.frameworks.asyncio import ASyncIOApp as App
from apistar.test import TestClient
from ssshelf.storages.inmemory import InMemoryStorage

from project.routes import routes
from project.db import short_url_manager


short_url_manager.set_storage(InMemoryStorage())

app = App(routes=routes)


def test_http_request():
    """
    Testing a view, using the test client.
    """
    client = TestClient(app)
    response = client.post(
      'http://localhost/new/',
      data=json.dumps({"url": "http://google.com"})
    )

    assert response.status_code == 200

    short_url = response.json().get('short_url')

    response = client.get(
      short_url,
      allow_redirects=False
    )

    assert response.status_code == 302
