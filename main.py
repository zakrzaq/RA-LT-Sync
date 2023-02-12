from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from markupsafe import Markup

from scripts.rtd_reports.archive_reports import archive_reports
from scripts.rtd_reports.convert_reports import convert_reports
from scripts.rtd_reports.filter_reports import filter_reports
from scripts.lt_sync.split_loadfile import split_loadfile
from scripts.lt_sync.process_ltsync import process_ltsync
import scripts.summary as summary
import scripts.exclusion as excl
import scripts.extension as extn
import scripts.utility as util

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
