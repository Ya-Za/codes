"""
order module contains 'Order' class
"""

import copy
import sys
from pprint import pprint

def main():
    """
    Test of 'Order' class

    e.x.1
    >>> order = Order(2)
    >>> order.compute_totalorders()
    >>> order.print_totalorders()
    Total orders: 0.125 (2/16)
    ----
    1
    ----
    1 1
    0 1

    [0, 1]
    ----
    2
    ----
    1 0
    1 1

    [1, 0]

    e.x.2
    >>> order = Order(2)
    >>> order.compute_dags()
    >>> order.print_dags()
    DAGs: 0.125 (2/16)
    ----
    1
    ----
    0 1
    0 0

    [[0], [1]]
    ----
    2
    ----
    0 0
    1 0

    [[1], [0]]

    e.x.3
    >>> Order.print_pathes([[False, True, True], [False, False, True], [False, False, False]])
    ----
    (0, 0)
    ----
    []
    ----
    (0, 1)
    ----
    [(0, 1)]
    ----
    (0, 2)
    ----
    [(0, 2)]
    [(0, 1), (1, 2)]
    ----
    (1, 0)
    ----
    []
    ----
    (1, 1)
    ----
    []
    ----
    (1, 2)
    ----
    [(1, 2)]
    ----
    (2, 0)
    ----
    []
    ----
    (2, 1)
    ----
    []
    ----
    (2, 2)
    ----
    []

    e.x.4
    >>> order = Order(2)
    >>> order.compute_trees()
    >>> order.print_trees()
    Trees: 0.125 (2/16)
    ----
    1
    ----
    0 1
    0 0

    [[0], [1]]
    ----
    2
    ----
    0 0
    1 0

    [[1], [0]]
    """
    # e.x.1
    # order = Order(4)
    # order.compute_totalorders()
    # order.print_totalorders()

    # e.x.2
    # order = Order(3)
    # order.compute_dags()
    # order.print_dags()

    # e.x.3
    # Order.print_pathes([[False, True, True], [False, False, True], [False, False, False]])
    # Order.print_pathes(Order.convert_edge_list_to_matrix(3, [(0, 1), (1, 2)]))
    # Order.print_pathes(Order.convert_edge_list_to_matrix(4, [(0, 1), (1, 2), (2, 3)]))

    # e.x.4
    order = Order(3)
    order.compute_trees()
    order.print_trees()

class Order(object):
    """
    Implements 'total order' and 'partial order'
    """

    def __init__(self, length):
        self.length = length              # number of vertices
        self.totalorders = []             # total order matrices
        self.dags = []                    # DAGs matrices
        self.trees = []                   # Trees matrices

    @staticmethod
    def get_all_matrices(length):
        """
        Get all possible length x length matrices
        """
        matrix = Order.init_matrix(length)
        while True:
            yield copy.deepcopy(matrix)

            if not Order.next_matrix(matrix):
                break

    def compute_totalorders(self):
        """
        Compute 'self.totalorders'
        """
        self.totalorders = \
            [
                matrix \
                for matrix in Order.get_all_matrices(self.length) \
                if Order.is_totalorder(matrix)
            ]

    @staticmethod
    def init_matrix(length):
        """
        Make zero 'length x length' matrix.
        """
        return [[False] * length for _ in range(length)]

    @staticmethod
    def is_totalorder(matrix):
        """
        Check that the matrix 'matrix' is total order or not
        """
        return Order.is_antisymmetric(matrix) and\
               Order.is_total(matrix)         and\
               Order.is_transitive(matrix)

    @staticmethod
    def is_antisymmetric(matrix):
        """
        if a != b and a R b => b !R a
        """
        length = len(matrix)
        for i in range(length):
            for j in range(length):
                if i != j and matrix[i][j]:
                    if matrix[j][i]:
                        return False

        return True

    @staticmethod
    def is_total(matrix):
        """
        a R b or b R a
        """
        length = len(matrix)
        for i in range(length):
            for j in range(length):
                if not (matrix[i][j] or matrix[j][i]):
                    return False

        return True

    @staticmethod
    def is_transitive(matrix):
        """
        if a R b and b R c => a R c
        """
        length = len(matrix)
        for i in range(length):
            for j in range(length):
                if matrix[i][j]:
                    for k in range(length):
                        if matrix[j][k]:
                            if not matrix[i][k]:
                                return False

        return True

    @staticmethod
    def next_matrix(matrix):
        """
        e.x. matrix = [[1, 0], [0, 0]]
        next_matrxi(matrix) == [[0, 1], [0, 0]]
        """
        length = len(matrix)
        for i in range(length):
            for j in range(length):
                if not matrix[i][j]:
                    matrix[i][j] = True
                    return True
                matrix[i][j] = False

        return False

    def print_totalorders(self):
        """
        Print analysis of totalorders
        """
        # number of total-orders
        number_of_totalorders = len(self.totalorders)
        number_of_all_matrices = 2 ** (self.length ** 2)
        ratio = number_of_totalorders / number_of_all_matrices
        print(\
            'Total order: {} ({}/{})'\
            .format(\
                ratio,\
                number_of_totalorders,\
                number_of_all_matrices\
            )\
        )

        # matrix of total-order relations
        index = 1
        for matrix in self.totalorders:
            print('----')
            print(index)
            print('----')
            Order.print_matrix(matrix)
            Order.print_order(matrix)

            index += 1

    @staticmethod
    def print_matrix(matrix):
        """
        e.x. matrix = [[True, False], [False, True]]
        1 0
        0 1

        """
        length = len(matrix)
        for i in range(length):
            for j in range(length):
                if matrix[i][j]:
                    sys.stdout.write('1 ')
                else:
                    sys.stdout.write('0 ')
            print()
        sys.stdout.flush()
        print()

    @staticmethod
    def print_order(matrix):
        """
        e.x.
        >>> Order.print_order([[1, 1], [0, 1]])
        >>> [1, 0]
        """
        length = len(matrix)
        res = list(range(length))

        for i in range(length - 1):
            for j in range(i + 1, length):
                if not matrix[res[i]][res[j]]:
                    res[i], res[j] = res[j], res[i]

        print(res)

    def compute_dags(self):
        """
        Compute 'self.dags'
        """
        self.dags = \
            [
                matrix \
                for matrix in Order.get_all_matrices(self.length) \
                if Order.is_dag(matrix)
            ]

    @staticmethod
    def is_dag(matrix):
        """
        Check that the matrix 'matrix' is dag or not
        """
        boolean_path_matrix = Order.get_boolean_path_matrix(matrix)

        # pathes with length 1
        length = len(boolean_path_matrix)
        for i in range(length):
            if boolean_path_matrix[i][i]:
                return False

        return Order.is_antisymmetric(boolean_path_matrix)

    @staticmethod
    def get_boolean_path_matrix(matrix):
        """
        boolean_path_matrix[i][j] = 1 if there is a path between 'i' and 'j' else 0
        e.x.
        >>> matrix = [[0, 1, 0], [0, 0, 1], [0, 0, 0]]
        >>> Order.get_boolean_path_matrix(matrix)
        [[0, 1, 1], [0, 0, 1], [0, 0, 0]]
        """
        boolean_path_matrix = copy.deepcopy(matrix)
        for _ in range(len(matrix) - 2):
            boolean_path_matrix = \
                Order.union(boolean_path_matrix, Order.multiply(boolean_path_matrix, matrix))

        return boolean_path_matrix

    @staticmethod
    def union(matrix1, matrix2):
        """
        Return union of 'matrix1' and 'matrix2'
        e.x.
        >>> matrix1 = [[0, 1], [0, 0]]
        >>> matrix2 = [[0, 0], [1, 0]]
        >>> Order.union(matrix1, matrix2)
        [[0, 1], [1, 0]]
        """
        res = copy.deepcopy(matrix1)
        length = len(matrix2)
        for i in range(length):
            for j in range(length):
                if matrix2[i][j]:
                    res[i][j] = True

        return res

    @staticmethod
    def multiply(matrix1, matrix2):
        """
        Return boolean multiply of 'matrix1' and 'matrix2'
        """
        length = len(matrix1)
        res = Order.init_matrix(length)
        for i in range(length):
            for j in range(length):
                for k in range(length):
                    if matrix1[i][k] and matrix2[k][j]:
                        res[i][j] = True
                        break

        return res

    def print_dags(self):
        """
        Print analysis of dags
        """
        # number of dags
        number_of_dags = len(self.dags)
        number_of_all_matrices = 2 ** (self.length ** 2)
        ratio = number_of_dags / number_of_all_matrices
        print(\
            'Dags: {} ({}/{})'\
            .format(\
                ratio,\
                number_of_dags,\
                number_of_all_matrices\
            )\
        )

        # matrix of dag relations
        index = 1
        for matrix in self.dags:
            print('----')
            print(index)
            print('----')
            Order.print_matrix(matrix)
            print(Order.get_layers(matrix))

            index += 1

    @staticmethod
    def get_layers(dag):
        """
        Get layers of the input 'dag'
        e.x.
        >>> Order.get_layers([[False, True], [False, False]])
        [[0], [1]]
        """
        layers = []
        nodes = list(range(len(dag)))
        boolean_path_matrix = Order.get_boolean_path_matrix(dag)

        current_layer = []
        while len(nodes):
            min_node = Order.min(nodes, boolean_path_matrix)
            if any(boolean_path_matrix[node][min_node] for node in current_layer):
                layers.append(copy.deepcopy(current_layer))
                current_layer = [min_node]
            else:
                current_layer.append(min_node)

            nodes.remove(min_node)

        layers.append(copy.deepcopy(current_layer))

        return layers

    @staticmethod
    def min(nodes, matrix):
        """
        Returen min node in 'nodes' based on the order is defined by 'matrix'
        e.x.
        >>> Order.min([0, 1], [[False, False], [True, False]])
        1
        """
        min_node = nodes[0]
        for node in nodes:
            if matrix[node][min_node]:
                min_node = node

        return min_node
    @staticmethod
    def print_pathes(matrix):
        """
        Print pathes of matrix 'matrix'
        """
        length = len(matrix)
        path_matrix = Order.get_path_matrix(matrix)

        # print pathes
        for i in range(length):
            for j in range(length):
                print('----')
                print((i, j))
                print('----')
                pprint(path_matrix[i][j])
                # for path in path_matrix[i][j]:
                #     print(path)

    @staticmethod
    def get_path_matrix(matrix):
        """
        path_matrix[i][j] = all pathes between 'i' and 'j'
        e.x.
        >>> matrix = [[False, True, True], [False, False, True], [False, False, False]]
        >>> Order.print_pathes()
        [
            [[], [[(0, 1)]], [[(0, 2)], [(0, 1), (1, 2)]]]
            [[], [], [[(1, 2)]]]
            [[], [], []]
        ]
        """
        converted_matrix = Order.convert_to_path_matrix(matrix)
        path_matrix = copy.deepcopy(converted_matrix)
        power_matrix = copy.deepcopy(converted_matrix)
        for _ in range(len(matrix) - 2):
            power_matrix = Order.cross_two_matrix(power_matrix, converted_matrix)
            path_matrix = \
                Order.concat(path_matrix, power_matrix)

        return path_matrix

    @staticmethod
    def convert_to_path_matrix(matrix):
        """
        Convert 'boolean matrix' to 'path matrix'
        e.x.
        >>> matrix =
        [
            [False, True],
            [False, False]
        ]
        >>> Order.convert_to_path_matrix(matrix)
        [
            [[], [[(0, 1)]]],
            [[], []]
        ]
        """
        length = len(matrix)
        path_matrix = [[] for _ in range(length)]
        for i in range(length):
            path_matrix[i] = [[] for _ in range(length)]

        for i in range(length):
            for j in range(length):
                if matrix[i][j]:
                    path_matrix[i][j].append([(i, j)])

        return path_matrix

    @staticmethod
    def concat(matrix1, matrix2):
        """
        Return concatenation of 'matrix1' and 'matrix2'
        e.x.
        >>> matrix1 =
        [
            [[], [[(0, 1)]]],
            [[], []]
        ]
        >>> matrix2 =
        [
            [[], [[(0, 2)]]],
            [[], []]
        ]
        >>> Order.union(matrix1, matrix2)
        [
            [[], [[(0, 1)], [(0, 2)]]],
            [[], []]
        ]
        """
        res = copy.deepcopy(matrix1)
        length = len(matrix2)
        for i in range(length):
            for j in range(length):
                res[i][j].extend(matrix2[i][j])

        return res

    @staticmethod
    def cross_two_matrix(matrix1, matrix2):
        """
        Return corss product of 'matrix1' and 'matrix2'
        e.x.
        >>> matrix1 =
        [
            [[], [[(0, 1)]]],
            [[], []]
        ]
        >>> matrix2 =
        [
            [[], []],
            [[]], [[(1, 2)]]]
        ]
        >>> Order.union(matrix1, matrix2)
        [
            [[], [[(0, 1), (0, 2)]]],
            [[]], []]
        ]
        """
        length = len(matrix1)
        res = [[] for _ in range(length)]
        for i in range(length):
            res[i] = [[] for _ in range(length)]

        for i in range(length):
            for j in range(length):
                for k in range(length):
                    res[i][j].extend(Order.cross_two_pathlist(matrix1[i][k], matrix2[k][j]))

        return res

    @staticmethod
    def cross_two_pathlist(pathlist1, pathlist2):
        """
        Return corss product of 'pathlist1' and 'pathlist2'
        e.x.
        >>> pathlist1 =
        [
            [(0, 3)],
            [(1, 2), (2, 3)]
        ]
        >>> pathlist2 =
        [
            [(3, 4)]
        ]
        >>> Order.union(matrix1, matrix2)
        [
            [(0, 3), (3, 4)],
            [(1, 2), (2, 3), (3, 4)]
        ]
        """
        res = []
        for path1 in pathlist1:
            for path2 in pathlist2:
                res.append(path1 + path2)

        return res

    @staticmethod
    def convert_edge_list_to_matrix(length, edge_list):
        """
        e.x.
        >>> length = 2
        >>> edge_list = [(0, 1), (1, 1)]
        >>> Order.convert_list_to_matrix(length, edge_list)
        [
            [False, True],
            [False, True]
        ]
        """
        matrix = Order.init_matrix(length)
        for edge in edge_list:
            matrix[edge[0]][edge[1]] = True

        return matrix

    def compute_trees(self):
        """
        Compute 'self.trees'
        """
        self.trees = \
            [
                matrix \
                for matrix in Order.get_all_matrices(self.length) \
                if Order.is_tree(matrix)
            ]

    @staticmethod
    def is_tree(matrix):
        """
        Check that the matrix 'matrix' is tree or not
        """
        return \
            Order.is_connected(matrix) and \
            len(Order.get_roots(matrix)) == 1 and \
            max(len(Order.get_parents(matrix, node)) for node in range(len(matrix))) < 2

    @staticmethod
    def is_connected(matrix):
        """
        Check that the matrix 'matrix' is connected.
        It means there is an un-directed path between every two vertices.
        """
        undirected_matrix = Order.get_undirected_matrix(matrix)
        vertices = [0]
        index = 0
        while index < len(vertices):
            for node in Order.get_childs(undirected_matrix, vertices[index]):
                if node not in vertices:
                    vertices.append(node)

            index += 1

        return len(vertices) == len(matrix)

    @staticmethod
    def get_undirected_matrix(matrix):
        """
        Return undirected version of input matrix
        e.x.
        >>> Order.get_undirected_matrix([[False, True], [False, False]])
        [[False, True], [True, False]]
        """
        undirected_matrix = copy.deepcopy(matrix)
        length = len(matrix)
        for i in range(length):
            for j in range(length):
                if matrix[i][j]:
                    undirected_matrix[j][i] = True

        return undirected_matrix


    @staticmethod
    def get_childs(matrix, vertex):
        """
        Return children of vertex 'vertex' in graph 'matrix'
        """
        return [node for node in range(len(matrix)) if matrix[vertex][node]]

    @staticmethod
    def get_parents(matrix, vertex):
        """
        Return parents of vertex 'vertex' in graph 'matrix'
        """
        return [node for node in range(len(matrix)) if matrix[node][vertex]]

    @staticmethod
    def get_roots(matrix):
        """
        Return roots graph 'matrix'.
        A root is a vertex which has no parents.
        """
        return [node for node in range(len(matrix)) if len(Order.get_parents(matrix, node)) == 0]

    def print_trees(self):
        """
        Print analysis of trees
        """
        # number of trees
        number_of_trees = len(self.trees)
        number_of_all_matrices = 2 ** (self.length ** 2)
        ratio = number_of_trees / number_of_all_matrices
        print(\
            'Trees: {} ({}/{})'\
            .format(\
                ratio,\
                number_of_trees,\
                number_of_all_matrices\
            )\
        )

        # matrix of tree relations
        index = 1
        for matrix in self.trees:
            print('----')
            print(index)
            print('----')
            Order.print_matrix(matrix)
            print(Order.get_layers(matrix))

            index += 1

if __name__ == '__main__':
    main()
