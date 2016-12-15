"""
Test generators.
"""
def main():
    """
    main function
    """
    # myrange = MyRange(10)
    # while True:
    #     value = myrange.next()
    #     if value is None:
    #         break
    #     print(value)

    # MyRange2.init(10)
    # while True:
    #     value = MyRange2.next()
    #     if value is None:
    #         break
    #     print(value)

    # for value in myrange3(10):
    #     print(value)

    # a = myrange3(10)
    # print(type(a))
    # print(a.__next__())

    # for value in MyRange4(10):
    #     print(value)

    # ex.6
    # print(mysum(5))

    # ex.7
    print(list(myrange(5)))


class MyRange:
    """
    Generator for range(n)
    """
    def __init__(self, max_value):
        self.max_value = max_value
        self.value = 0

    def reset(self):
        """
        Set 'self.value' to 0
        """
        self.value = 0

    def next(self):
        """
        Return self.value + 1
        """
        if self.value < self.max_value:
            res = self.value
            self.value += 1
        else:
            res = None
            self.reset()

        return res

class MyRange2:
    """
    Generator for range(n)
    """
    @staticmethod
    def init(max_value):
        """
        Static constructor
        """
        MyRange2.max_value = max_value
        MyRange2.value = 0

    @staticmethod
    def reset():
        """
        Set 'MyRange2.value' to 0
        """
        MyRange2.value = 0

    @staticmethod
    def next():
        """
        Return MyRange2.value + 1
        """
        if MyRange2.value < MyRange2.max_value:
            res = MyRange2.value
            MyRange2.value += 1
        else:
            res = None
            MyRange2.reset()

        return res

def myrange3(max_value):
    """
    renge(max_value)
    """
    value = 0
    while value < max_value:
        yield value
        value += 1

class MyRange4:
    """
    Generator for range(n)
    """
    def __init__(self, max_value):
        self.max_value = max_value
        self.value = 0

    def reset(self):
        """
        Set 'self.value' to 0
        """
        self.value = 0

    def __iter__(self):
        """
        Iterable
        """
        return self

    def __next__(self):
        """
        Return self.value + 1
        """
        if self.value < self.max_value:
            res = self.value
            self.value += 1
            return res
        else:
            self.reset()
            raise StopIteration()

def mysum(num):
    """
    MYSUM returns sum(1, ..., num).
    ex.
    >>> mysum(5)
    15
    """
    if num == 0:
        return 0
    return num + mysum(num - 1)

def myrange(num):
    """
    MYRANGE returns num, num-1, ..., 1
    ex.
    >>> list(myrange(5))
    [5, 4, 3, 2, 1]
    """
    if num > 0:
        yield num
        yield from myrange(num - 1)



if __name__ == '__main__':
    main()
