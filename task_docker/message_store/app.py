from flask import Flask, request, jsonify
import json
import os
import uuid

app = Flask(__name__)

MESSAGE_STORAGE_PATH = os.environ.get('MESSAGE_STORAGE_PATH', '/data/messages')

os.makedirs(MESSAGE_STORAGE_PATH, exist_ok=True)


@app.route('/store', methods=['POST'])
def store_message():
    data = request.json

    random_string = str(uuid.uuid4())
    filename = f"msg-{random_string}.json"

    file_path = os.path.join(MESSAGE_STORAGE_PATH, filename)

    with open(file_path, 'w') as file:
        json.dump(data, file)

    return jsonify({"file": filename})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8082)
