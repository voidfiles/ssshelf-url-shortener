from apistar import Include, Route
from apistar.docs import docs_routes
from apistar.statics import static_routes
from project.views import new, redirect

routes = [
    Route('/{short_url}/', 'GET', redirect),
    Route('/new/http://www.{url}.com/', 'GET', new),
    Route('/new/https://www.{url}.com/', 'GET', new),
    Include('/docs', docs_routes),
    Include('/static', static_routes)
]
