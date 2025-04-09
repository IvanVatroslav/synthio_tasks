from flask import Flask, request, jsonify
import requests
import datetime
import os

app = Flask(__name__)

STORAGE_SERVICE_URL = os.environ.get('STORAGE_SERVICE_URL', 'http://localhost:8082/store')


@app.route('/messages', methods=['POST'])
def process_message():
    data = request.json

    transformed_message = {
        "msg": data.get("message", ""),
        "dateTimeSent": datetime.datetime.now().isoformat()
    }

    response = requests.post(STORAGE_SERVICE_URL, json=transformed_message)

    return response.json()


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)
