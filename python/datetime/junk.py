def main():
    mc = MyClass()
    print(mc.value)
    print(MyClass.value)
    mc.value = 10
    print(mc.value)
    print(MyClass.value)
    MyClass.value = 20
    print(mc.value)
    print(MyClass.value)
    

class MyClass(object):
    value = 0
    def __init__(self):
        pass

    def set_value(v):
        MyClass.value = v

MyClass.set_value(5)

if __name__ == '__main__':
    main()