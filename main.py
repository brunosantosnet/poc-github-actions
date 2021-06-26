import requests
from fastapi import FastAPI, Depends, Form

app = FastAPI()

@app.get('/test')
async def root():
    return {'message': 'Hello World!'}
