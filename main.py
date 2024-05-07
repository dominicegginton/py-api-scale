#!/usr/bin/env python

import asyncio
import uvicorn
import time

from fastapi import FastAPI

app = FastAPI()

def long_running_task():
    time.sleep(0.1)

# @app.get("/")
# def root():
#     long_running_task()
#     return None

# async will cause fast api to *await* for a response from
# this router function blocking the event loop until the
# response is ready
@app.get("/")
async def root():
    long_running_task()
    return None


async def main():
    config = uvicorn.Config(
        "main:app",
        log_level="debug",
        loop="asyncio",
        host="localhost",
        port=8000,
        # workers=1, # number of processes to fork
        # limit_concurrency=2, # max number of requests being processed at a time
        # backlog=1, # max number of requests waiting to be processed (default 2048) requests will be dropped if this is exceeded
    )
    server = uvicorn.Server(config)
    await server.serve()

if __name__ == "__main__":
    asyncio.run(main())
