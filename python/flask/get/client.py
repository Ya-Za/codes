"""
CLIENT
"""
import requests

def main():
    """
    MAIN
    """
    response = requests.get('http://127.0.0.1:5000')
    if response.ok:
        print(response.text)

if __name__ == '__main__':
    main()
