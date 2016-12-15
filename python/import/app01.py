"""
'app01.py' module
"""
import folder01

def main():
    """
    Main class of 'app01.py'
    """
    folder01.app02.print_message()
    app = folder01.app02.App02()
    app.print_message()


if __name__ == '__main__':
    main()
