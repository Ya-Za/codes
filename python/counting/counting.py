"""
Counting method includes 'production rule', 'permutation', 'selection'
"""
from pprint import pprint
from functools import cmp_to_key
import random

def main():
    """
    ex.1
    >>> for state in production_rule([3, 2]):
    ...     print(state)
    ...
    [0, 0]
    [0, 1]
    [1, 0]
    [1, 1]
    [2, 0]
    [2, 1]

    ex.2
    >>> for state in permutation(3, 2):
    ...     print(state)
    ...
    [0, 1]
    [0, 2]
    [1, 0]
    [1, 2]
    [2, 0]
    [2, 1]

    ex.3
    >>> for state in combination(4, 2):
    ...     print(state)
    ...
    [0, 1]
    [0, 2]
    [0, 3]
    [1, 2]
    [1, 3]
    [2, 3]

    ex.4
    >>> random_permutation(3)
    [2, 1, 3]


    ex.8
    >>> data = [
        [1, 0],
        [1, 1],
        [0, 0],
        [0, 1]
    ]
    >>> sorted(data, key=cmp_to_key(lexical))
    [
        [0, 0],
        [0, 1],
        [1, 0],
        [1, 1]
    ]
    """
    # ex.1
    # for state in production_rule([3, 2]):
    #     print(state)

    # ex.2
    # pr = ProductionRule([3, 2])
    # for state in pr.get_states():
    #     print(state)

    # ex.3
    # n, k = 3, 3
    # print(len(list(permutation(n, k))))
    # for state in permutation(n, k):
    #     print(state)

    # ex.4
    # n, k = 3, 3
    # p = Permutation(n, k)
    # for state in p.get_states():
    #     print(state)

    # ex.5
    # n, k = 3, 2
    # print(len(list(combination(n, k))))
    # for state in combination(n, k):
    #     print(state)

    # ex.6
    # n, k = 3, 2
    # c = Combination(n, k)
    # for state in c.get_states():
    #     print(state)

    # ex.7
    # for _ in range(10):
    #     print(random_permutation(3))

    # ex.8
    data = [
        [1, 0],
        [1, 1],
        [0, 0],
        [0, 1]
    ]
    pprint(sorted(data, key=cmp_to_key(lexical)))

class ProductionRule():
    """
    Implements production rule.
    ex.
    >>> list(ProductionRule([2, 2]))
    [
        [0, 0],
        [0, 1],
        [1, 0],
        [1, 1]
    ]
    """
    def __init__(self, lengths):
        self.lengths = lengths

        self.max_level = len(self.lengths)
        self.state = [0] * self.max_level

    def get_states(self):
        """
        Return all possible states.
        """
        yield from self.recursive_next(0)

    def recursive_next(self, level):
        """
        Recursively return next state
        """
        if level == self.max_level:
            yield self.state
        else:
            for value in range(self.lengths[level]):
                self.state[level] = value
                yield from self.recursive_next(level + 1)

def production_rule(lengths):
    """
    Implements production rule.
    ex.
    >>> list(production_rule([2, 2]))
    [
        [0, 0],
        [0, 1],
        [1, 0],
        [1, 1]
    ]
    """
    # code #1
    # state = [0] * len(lengths)
    # yield state

    # end_index = len(state) - 1
    # while True:
    #     index = end_index
    #     while index > -1:
    #         state[index] += 1
    #         if state[index] < lengths[index]:
    #             yield state
    #             break
    #         else:
    #             state[index] = 0
    #             index -= 1
    #     if index < 0:
    #         break

    # code #2
    state = [0] * len(lengths)
    yield state

    index = len(state) - 1
    while index > -1:
        state[index] += 1
        if state[index] < lengths[index]:
            for index in range(index + 1, len(state)):
                state[index] = 0
            yield state
        else:
            index -= 1

class Permutation():
    """
    k-permuations of n
    ex.
    >>> list(permutation(2, 2))
    [
        [0, 1],
        [1, 0]
    ]
    """
    def __init__(self, n, k):
        self.n = n
        self.k = k

        self.state = [0] * k
        self.selected = []

    def get_states(self):
        """
        Return all possible states.
        """
        yield from self.recursive_next(0)

    def recursive_next(self, index):
        """
        Recursively return next state
        """
        if index == self.k:
            yield self.state
        else:
            for value in range(self.n):
                if value not in self.selected:
                    self.state[index] = value
                    self.selected.append(value)
                    yield from self.recursive_next(index + 1)
                    self.selected.remove(value)

def permutation(n, k):
    """
    k-permuations of n
    ex.
    >>> list(permutation(2, 2))
    [
        [0, 1],
        [1, 0]
    ]
    """
    # code #1
    # state = list(range(k))
    # yield state

    # end_index = k - 1
    # selected = list(range(k))
    # while True:
    #     index = end_index
    #     while index > -1:
    #         selected.remove(state[index])
    #         state[index] += 1
    #         while state[index] in selected:
    #             state[index] += 1
    #         if state[index] < n:
    #             selected.append(state[index])
    #             index += 1
    #             while index < k:
    #                 for i in range(n):
    #                     if i not in selected:
    #                         state[index] = i
    #                         selected.append(i)
    #                         break
    #                 index += 1
    #             yield state
    #             break
    #         else:
    #             index -= 1

    #     if index < 0:
    #         break

    # code #2
    # for state in production_rule([n] * k):
    #     if len(set(state)) == k:
    #         yield state

    # code #3
    state = list(range(k))
    yield state

    selected = list(range(k))
    index = k - 1

    while index > -1:
        selected.remove(state[index])
        state[index] += 1
        while state[index] in selected:
            state[index] += 1
        if state[index] < n:
            selected.append(state[index])
            for index in range(index + 1, k):
                for value in range(n):
                    if value not in selected:
                        state[index] = value
                        selected.append(value)
                        break
            yield state
        else:
            index -= 1

def combination(n, k):
    """
    k-combination of n
    ex.
    >>> list(combination(4, 2))
    [
        [0, 1],
        [0, 2],
        [0, 3],
        [1, 2],
        [1, 3],
        [2, 3]
    ]
    """
    # code #1
    # state = list(range(k))
    # yield state

    # end_index = len(state) - 1
    # while True:
    #     index = end_index
    #     while index > -1:
    #         state[index] += 1
    #         if state[index] < n - ((k - 1) - index):
    #             index += 1
    #             while index < k:
    #                 state[index] = state[index - 1] + 1
    #                 index += 1
    #             yield state
    #             break
    #         else:
    #             index -= 1
    #     if index < 0:
    #         break

    # code #2
    # for state in permutation(n, k):
    #     if all(state[i] < state[i+1] for i in range(k - 1)):
    #         yield state

    # code #3
    # for state in production_rule([n] * k):
    #     if all(state[i] < state[i+1] for i in range(k - 1)):
    #         yield state

    # code #4
    state = list(range(k))
    yield state

    index = k - 1
    while index > -1:
        state[index] += 1
        if state[index] < (n - k + index + 1):
            for index in range(index + 1, k):
                state[index] = state[index - 1] + 1
            yield state
        else:
            index -= 1

class Combination():
    """
    k-combination of n
    ex.
    >>> list(combination(4, 2))
    [
        [0, 1],
        [0, 2],
        [0, 3],
        [1, 2],
        [1, 3],
        [2, 3]
    ]
    """
    def __init__(self, n, k):
        self.n = n
        self.k = k

        self.state = [0] * k

    def get_states(self):
        """
        Return all possible states.
        """
        yield from self.recursive_next(0, 0)

    def recursive_next(self, next_value, index):
        """
        Recursively return next state
        """
        if index == self.k:
            yield self.state
        else:
            for value in range(next_value, self.n - self.k + index + 1):
                self.state[index] = value
                yield from self.recursive_next(value + 1, index + 1)

def random_permutation(n):
    """
    Return random permutaion of length 'n'
    ex.
    >>> random_permutaton(3)
    [2, 1, 3]
    """
    numbers = list(range(n))
    res = []
    while len(numbers):
        index = random.randrange(len(numbers))
        res.append(numbers[index])
        del numbers[index]

    return res

def lexical(a, b):
    """
    LEXICAL lexcial comparision between 'a' and 'b'.
    CONSTRAITS:
    1. len(a) == len(b)
    ex.
    >>> lexical([1, 2], [1, 3])
    -1
    """
    if len(a) != len(b):
        raise Exception('len(a) must be equal to len(b).')

    for (x, y) in zip(a, b):
        if x < y:
            return -1
        if x > y:
            return 1

    return 0

if __name__ == '__main__':
    main()
