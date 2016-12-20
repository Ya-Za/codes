"""
YZ_IMPORT try to understand python compiler!
"""
import os
import re

def main():
    """
    MAIN tests module
    ex.1
    >>> path = './file01.txt'
    >>> tree = Tree(path)
    >>> print(tree)
    >>> print(tree.is_valid(path))
    def('a')
    call('a')
    {
        call('a')
        def('b')
    }
    call('a')
    True
    """
    # ex.1
    path = './file01.txt'
    tree = Tree(path)
    print(tree)
    print(tree.is_valid())

class Tree(object):
    """
    TREE makes a tree from a file with given path.
    """
    def __init__(self, path):
        """
        PARAM path as str: path of file
        """
        self.path = path
        self.root = self.make_tree()

    def make_tree(self):
        """
        MAKE_TREE makes a tree from a file with given path.
        """
        (filename, _) = os.path.splitext(os.path.basename(self.path))
        root = Node(filename)
        for line in open(self.path):
            line = str.strip(line)
            if line == '{':
                root.childs.append(Node(name='', parent=root))
                root = root.childs[-1]
            elif line == '}':
                root = root.parent
            else:
                root.childs.append(Node(name=line, parent=root))

        return root

    def __str__(self):
        root = self.root
        res = []
        Tree.recursive_str(root, res, '')
        return '\n'.join(res)

    @staticmethod
    def recursive_str(root, res, tab):
        """
        RECURSIVE_STR makes string representaion of the tree determined by given 'root'
        PARAM root as Node: root of tree
        PARAM res as [str]: result
        PARAM tab as str: specifies the indentation
        """
        for node in root.childs:
            if len(node.childs) == 0:
                res.append(tab + node.name)
            else:
                res.append(tab + '{')
                Tree.recursive_str(node, res, tab + '\t')
                res.append(tab + '}')

    def is_valid(self):
        """
        IS_VALID check that a module with given 'path' is valid or not.
        """
        return all(\
            self.is_valid_call_node(call_node) \
            for call_node in self.get_call_nodes(self.root) \
        )

    def get_call_nodes(self, root):
        """
        GET_CALL_NODES returns all call nodes
        """
        if str.startswith(root.name, 'call'):
            yield root
        for node in root.childs:
            yield from self.get_call_nodes(node)

    def get_def_nodes(self, root):
        """
        GET_DEF_NODES returns all def nodes of a node
        """
        if root is None:
            return
        for node in root.childs:
            if str.startswith(node.name, 'def'):
                yield node
        yield from self.get_def_nodes(root.parent)

    def is_valid_call_node(self, call_node):
        """
        IS_VALID_CALL_NODE returns true if there is an 'def' node in
        """
        call_text = Tree.get_text_of_node(call_node)
        return any(\
            Tree.get_text_of_node(def_node) == call_text \
            for def_node in self.get_def_nodes(call_node.parent) \
        )

    @staticmethod
    def get_text_of_node(node):
        """
        GET_TEXT_OF_NODE returns text of 'call(text)' or 'def(text)'
        """
        pattern = r'(?:call|def)\((\w+)\)'
        match = re.search(pattern, node.name)
        return match.group(1)


class Node(object):
    """
    NODE implements node of tree
    """
    def __init__(self, name, parent=None):
        self.name = name
        self.parent = parent
        self.childs = []

if __name__ == '__main__':
    main()
