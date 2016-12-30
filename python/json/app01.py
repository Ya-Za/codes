"""
APP01.PY tests json in python
"""
from pprint import pprint
import json

def main():
    """
    MAIN tests module
    """
    filename = './data01.json'
    pprint(json.load(open(filename)))

if __name__ == '__main__':
    main()
