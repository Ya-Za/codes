"""
APP01 test some asspects of python decorators
"""

def main():
    """
    MAIN tests module
    """
    f1()

def f1():
    message = 'Hello, World!'
    def f2():
        print(message)
    f2()

if __name__ == '__main__':
    main()
