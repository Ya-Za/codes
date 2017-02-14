"""
SERVER
"""
from flask import Flask, send_file

app = Flask(__name__)
@app.route('/', methods=['GET', 'POST'])
def main():
    """
    MAIN
    """
    return send_file(
        open('./lynda.zip', 'rb'),
        as_attachment=False,
        attachment_filename='lynda.zip',
        mimetype='application/zip'
    )

if __name__ == '__main__':
    app.run(debug=True)
