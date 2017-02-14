"""
CLIENT
"""
import requests
import shutil

def main():
    """
    MAIN
    """
    print('---Begin---')
    res = requests.post('http://127.0.0.1:5000', stream=True)
    print(res.ok)
    print('---End---')
    shutil.copyfileobj(res.raw, open('zzz.zip', 'wb'))

if __name__ == '__main__':
    main()
