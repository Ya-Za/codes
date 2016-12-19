"""
YZ_IMPORT try to understand python compiler!
"""
def main():
    """
    MAIN test module
    ex.1
    >>> path = './file01.txt'
    >>> tree = Tree(path)
    >>> print(tree.is_valid(path))
    True
    """
    path = './file01.txt'
    tree = Tree(path)
    print(tree.is_valid())

class Tree(object):
    """
    TREE makes a tree from a module with given path.
    """
    def __init__(self, path):
        self.path = path
        self.root = self.make_tree()

    def make_tree(self):
        """
        MAKE_TREE makes a tree from a module with given path.
        """
        root = Node('

    def is_valid(self):
        """
        IS_VALID check that a module with given 'path' is valid or not.
        """
        pass



if __name__ == '__main__':
    main()
