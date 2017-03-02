"""
YZXPATH
"""
from pprint import pprint
from lxml import etree


def main():
    """
    MAIN
    """
    filename = './bookstore.xml'

    xpath = YZXpath(filename)
    # print(xpath)
    # YZXpath.dfs(xpath.root)
    # YZXpath.bfs(xpath.root)
    # pprint(xpath.__dict__())
    # pprint(xpath.json())

    # for element in xpath.iter(tags=['book', 'price']):
    #     print(element.tag)

    for element in xpath.descendants(xpath.root, 'book'):
        print(element.tag)


class YZXpath:
    """
    YZXPATH
    """

    def __init__(self, filename):
        self.tree = etree.parse(filename)
        self.root = self.tree.getroot()

    def __str__(self):
        return etree.tostring(self.tree, pretty_print=True).decode('ascii')

    def iter(self, root=None, tags=None):
        """
        ITER
        """
        def recursive_iter(element):
            """
            RECURSIVE_ITER
            """
            if tags is None or element.tag in tags:
                yield element
            for child in element:
                yield from recursive_iter(child)

        if root is None:
            root = self.root
        return recursive_iter(root)

    def __dict__(self):
        def make_text_node(text):
            """
            make_text_node
            """
            return {
                'type': 'text',
                'content': text
            }

        def get_dict(element):
            """
            GET_DICT
            """
            res = {
                'type': 'element',
                'tag': element.tag,
                'attribs': dict(element.attrib)
            }

            res['child'] = []
            text = element.text.strip()
            if text != '':
                res['child'].append(make_text_node(text))
            for child in element:
                res['child'].append(get_dict(child))
                text = child.tail.strip()
                if text != '':
                    res['child'].append(make_text_node(text))

            return res

        return get_dict(self.root)

    def json(self):
        """
        JSON
        """
        def recursive_json(element):
            """
            RECURSIVE_JSON
            """

            # just text
            if len(element) == 0 and len(element.attrib) == 0:
                return element.text

            res = {}
            # text
            text = element.text.strip()
            if text != '':
                res['#text'] = text
            # attributes
            for key, value in element.items():
                # res[f'@{key}'] = value
                res['@{}'.format(key)] = value
            # child elements
            for child in element:
                tag = child.tag
                content = recursive_json(child)
                if tag in res:
                    if isinstance(res[tag], list):
                        res[tag].append(content)
                    else:
                        res[tag] = [res[tag], content]
                else:
                    res[tag] = content

            return res

        return {
            self.root.tag: recursive_json(self.root)
        }

    @staticmethod
    def dfs(element):
        """
        DFS
        """
        print(element.tag)
        for child in element:
            YZXpath.dfs(child)

    @staticmethod
    def bfs(element):
        """
        BFS
        """
        queue = [element]
        while len(queue):
            element = queue.pop()
            print(element.tag)
            for child in element:
                queue.insert(0, child)

    def descendants(self, element, tag):
        """
        DESCENDANTS
        """
        yield from self.iter(element, [tag])


if __name__ == '__main__':
    main()
