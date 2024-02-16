from fastapi import FastAPI
import uvicorn
import requests

app = FastAPI()


class ObjectLike(dict):
    __getattr__ = dict.get


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/books/{isbn}")
def read_item(isbn: str):
    url = f"https://api.openbd.jp/v1/get?isbn={isbn}&pretty"
    try:
        print(f"url: {url}")
        response = requests.get(url)
        res_json = response.json(object_hook=ObjectLike)
        if res_json[0] is None:
            raise Exception(f"Does not exists. [{isbn}]")
        else:
            return res_json[0]
    except Exception as e:
        raise e


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)