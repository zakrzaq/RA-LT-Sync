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
server_on = True


def dummy(req):
    return {"request": req, "output": Markup("test output"), "title": "test title"}


def index(req):
    return {"request": req, "output": None, "title": "Main menu"}


@app.get("/test")
async def test(id: str | None = None):
    print(id)
    return {"id": id}


@app.get("/", response_class=HTMLResponse)
async def root(request: Request):
    return templates.TemplateResponse("index.html", index(request))


# Planning
@app.get("/rtd_filter", response_class=HTMLResponse)
async def rtd_filter(request: Request, date: str):
    output, title = filter_reports(True)
    return templates.TemplateResponse(
        "index.html", {"req": request, "output": output, "title": title}
    )


@app.get("/rtd_convert")
async def rtd_convert(date: str | None):
    print(date)
    output, title = convert_reports(server=True, date=date)
    return templates.TemplateResponse("index.html", {"output": output, "title": title})


@app.get("/rtd_clean", response_class=HTMLResponse)
async def rtd_clean(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))


@app.get("/rtd_aio", response_class=HTMLResponse)
async def rtd_aio(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))


# LT Sync
@app.get("/lt_process", response_class=HTMLResponse)
async def lt_process(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))


@app.get("/lt_split", response_class=HTMLResponse)
async def lt_split(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))


@app.get("/lt_aio", response_class=HTMLResponse)
async def lt_aio(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))


# summary etc
@app.get("/summary", response_class=HTMLResponse)
async def summary(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))


@app.get("/exclusion", response_class=HTMLResponse)
async def exclusion(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))


@app.get("/extension", response_class=HTMLResponse)
async def extension(request: Request):
    return templates.TemplateResponse("index.html", dummy(request))
