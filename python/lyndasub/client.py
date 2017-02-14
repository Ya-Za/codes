"""
CLIENT
"""
# import codecs
import shutil
import re
import requests


def main():
    """
    MAIN
    """
    response = requests.post(
        'http://127.0.0.1:5000/',
        json={'url': 'https://www.lynda.com/D3-js-tutorialyndasub_/D3-js-Essential-Training-DATA-Scientists/504428-2.html'},
        stream=True
    )

    if response.ok:
        shutil.copyfileobj(
            response.raw,
            open(get_filename(response), 'wb'))

        # DATA = response.json()
        # open(DATA['name'], 'wb')\
        #     .write(\
        #     codecs.decode(\
        #         bytearray(DATA['content'], encoding='ascii'),\
        #         'base64'\
        #     )\
        # )

def get_filename(response):
    """
    GET_FILENAME
    """
    return re.search("filename=\"(.+)\"", response.headers['content-disposition']).group(1)

if __name__ == '__main__':
    main()
