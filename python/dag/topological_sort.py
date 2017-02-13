"""
TOPOLOGICAL_SORT
(Kahn's algorithm)[https://en.wikipedia.org/wiki/Topological_sorting#Khan's algorithm]
"""

def main():
    """
    MAIN
    """
    graph = {
        'number_of_vertices': 5,
        'edges': [
            (3, 1),
            (3, 0),
            (2, 1),
            (1, 0)
        ]
    }

    print(topological_sort(graph, method='dfs'))

def get_adjacency_list(graph):
    """
    GET_ADJACENCY_LIST
    """

    adjacency_list = [[] for _ in range(graph['number_of_vertices'])]
    for edge in graph['edges']:
        adjacency_list[edge[0]].append(edge[1])

    return adjacency_list

def kahn(graph):
    """
    TOPOLOGICAL_SORT
    """
    number_of_vertices = graph['number_of_vertices']
    vertices = list(range(number_of_vertices))

    number_of_incoming_edges = [0] * number_of_vertices
    for edge in graph['edges']:
        number_of_incoming_edges[edge[1]] += 1

    ordered_vertices = []
    queue = list(\
        vertex\
        for vertex in vertices\
        if number_of_incoming_edges[vertex] == 0\
    )

    adjacency_list = get_adjacency_list(graph)
    while len(queue) > 0:
        vertex = queue.pop()
        ordered_vertices.append(vertex)

        for neigbour in adjacency_list[vertex]:
            number_of_incoming_edges[neigbour] -= 1
            if number_of_incoming_edges[neigbour] == 0:
                queue.append(neigbour)

    for number in number_of_incoming_edges:
        if number > 0:
            raise Exception('Graph is not a DAG!')

    return ordered_vertices

def dfs(graph):
    """
    DFS
    """
    number_of_vertices = graph['number_of_vertices']
    vertices = list(range(number_of_vertices))
    mark_of_vertices = [0] * number_of_vertices
    adjacency_list = get_adjacency_list(graph)
    ordered_vertices = []

    def visit(vertex):
        """
        VISIT
        """
        nonlocal mark_of_vertices, adjacency_list, ordered_vertices

        if mark_of_vertices[vertex] == 1:
            raise Exception('Graph is not a DAG!')

        if mark_of_vertices[vertex] == 0:
            mark_of_vertices[vertex] += 1
            for neighbour in adjacency_list[vertex]:
                visit(neighbour)
            mark_of_vertices[vertex] += 1
            ordered_vertices.insert(0, vertex)

    for vertex in vertices:
        if mark_of_vertices[vertex] == 0:
            visit(vertex)

    return ordered_vertices

def topological_sort(graph, method='kahn'):
    """
    TOPOLOGICAL SORT
    """
    if method == 'kahn':
        return kahn(graph)
    elif method == 'dfs':
        return dfs(graph)
    else:
        raise Exception(f'There is no "{method}" method!')

if __name__ == '__main__':
    main()
