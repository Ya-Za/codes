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
    print(request.json)
    # data = LyndaSub.zip(**request.json)
    # return jsonify(data)

    filename = LyndaSub.zip(**request.json)
    return send_file(
        open(filename, 'rb'),
        as_attachment=True,
        attachment_filename=os.path.basename(filename),
        mimetype='application/zip'
    )


if __name__ == '__main__':
    app.run(debug=True)
