from apistar import Include, Route
from apistar.handlers import docs_urls, static_urls
from project.views import new, redirect
from apistar.frameworks.wsgi import WSGIApp as App

routes = [
    Route('/new/', 'POST', new),
    Include('/docs', docs_urls),
    Include('/static', static_urls),
    Route('/{short_url}/', 'GET', redirect),
]

app = App(routes=routes)
