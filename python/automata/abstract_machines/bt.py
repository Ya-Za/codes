# backtracking
def main():
    tree = {
        'a': ['b', 'c', 'd'],
        'b': ['e', 'f'],
        'c': ['g', 'h'],
        'd': ['i', 'j']
    }
    root = 'a'

    bt = Backtracking(tree, root)
    bt.find('k')
    print(bt.path)

class Backtracking(object):
    def __init__(self, tree, root):
        self.tree = tree
        self.root = root
        self.target = None
        self.path = None

    def find(self, target):
        self.target = target
        self.path = []
        self.rec_find(self.root)
        self.path.reverse()

    def rec_find(self, node):
        if node == self.target:
            self.path.append(node)

        if node not in self.tree:
            return
        for child in self.tree[node]:
            self.rec_find(child)
            if len(self.path) > 0:
                self.path.append(node)
                return

if __name__ == '__main__':
    main()