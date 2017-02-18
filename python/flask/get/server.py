"""
SERVER
"""
from pprint import pprint
from flask import Flask, request


app = Flask(__name__)

def print_args(**kwargs):
    """
    PRINT_ARGS
    """
    print(kwargs)

@app.route('/', methods=['GET', 'POST'])
def hello():
    """
    HELLO
    """
    print(request.method)
    args = {key:value[0] for key, value in request.args.items()}
    print_args(**args)
    return 'Hello, Yasin!'

if __name__ == '__main__':
    app.run()
