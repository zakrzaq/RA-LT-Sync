from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from markupsafe import Markup

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")


templates = Jinja2Templates(directory="templates")


def dummy(req):
    return {"request": req, "output": Markup("test output"), "title": "test title"}


@app.get("/")
async def root():
    return {"message": "Planning Plause & LT Sync"}


@app.get("/test", response_class=HTMLResponse)
async def read_item(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))
