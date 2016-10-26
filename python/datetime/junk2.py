from junk import MyClass
def main():
    mc1 = MyClass()
    print(mc1.value)
    MyClass.value = 7
    mc2 = MyClass()
    print(mc1.value)
    print(mc2.value)

if __name__ == '__main__':
    main()