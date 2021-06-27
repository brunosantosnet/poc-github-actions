import uvicorn
import requests
from fastapi import FastAPI, Depends, Form

app = FastAPI()

@app.get('/test')
async def root():
    return "TECH TALK github actions: SRE, Cloud Engineering and Platform Engineering. We are stronger together"

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=5000, log_level="info")
