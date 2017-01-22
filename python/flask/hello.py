"""
HELLO print 'Hello, World!' after request 'http://localhost:5000
"""
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    """
    HELLO returns 'Hello, World!'
    """
    return 'Hello, World!'

if __name__ == '__main__':
    app.run()
