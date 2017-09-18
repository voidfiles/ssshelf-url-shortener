from project.routes import routes
from apistar.frameworks.asyncio import ASyncIOApp as App

app = App(routes=routes)
