from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from bson.objectid import ObjectId
import socket
import os

app = Flask(__name__)
db_url = os.getenv("DB_URL") #Coming from secrets
db_env = os.getenv("DB_ENV") #Coming from configmap
url_scheme = os.getenv("URL_SCHEME") #Coming from configmap
app.config["MONGO_URI"] = db_url
app.config["ENV"] = db_env
app.config["PREFFERED_URL_SCHEME"] = url_scheme
mongo = PyMongo(app)
db = mongo.db

@app.route("/")
def index():
    hostname = socket.gethostname()
    return jsonify(message="Server Up and Running! I'm running inside {} pod!".format(hostname))

@app.route("/form", methods=["POST"])
def create_data():
    data = request.get_json(force=True)
    db.sample_form.insert_one({"name": data["name"], "age": data["age"], "address": data["address"], "phone": data["phone"], "pincode": data["pincode"]})
    return jsonify(message="Successfully inserted one document!")

@app.route("/list")
def list_data():
    datalist = db.sample_form.find()
    displist = []
    for doc in datalist:
        item = {
            "_id": str(doc["_id"]),
            "name": doc["name"],
            "age": doc["age"],
            "address": doc["address"],
            "phone": doc["phone"],
            "pincode": doc["pincode"]
        }
        displist.append(item)
    return jsonify(
        data=displist
    )
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
