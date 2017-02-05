def main():
    message = 'yasin'
    def fun():
        nonlocal message
        print(message)
        # message = 'ali'
        # print(message)

    fun()
    print(message)

if __name__ == '__main__':
    main()