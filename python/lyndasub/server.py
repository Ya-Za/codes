"""
SERVER
"""
from flask import Flask, request, jsonify, send_file
from io import BytesIO
from lyndasub import LyndaSub
import os

app = Flask(__name__)
@app.route('/', methods=['GET', 'POST'])
def lyndasub():
    """
    LYNDASUB
    """
    # print(request.json)
    # data = LyndaSub.zip(**request.json)
    # return jsonify(data)

    args = {}
    if request.method == 'GET':
        args = {key:value for key, value in request.args.items()}
        # args = request.args
    else:
        args = request.json

    print(args)
    filename = LyndaSub.zip(**args)
    return send_file(
        open(filename, 'rb'),
        as_attachment=True,
        attachment_filename=os.path.basename(filename),
        mimetype='application/zip'
    )


if __name__ == '__main__':
    app.run()
