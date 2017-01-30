"""
SIMPLE_XML
"""

def main():
    """
    MAIN
    """

    obj = loads(\
        open('simple_xml_input.xml').read()\
    )
    open('simple_xml_output.xml', 'w').\
        write(dumps(obj, 2, '\n'))

def test_dumps():
    """
    TEST_DUMPS
    """

    tree = {
        'name': 1,
        'childs': [
            {
                'name': 2,
                'childs': [
                    {
                        'name': 4,
                        'childs': []
                    },
                    {
                        'name': 5,
                        'childs': [
                            {
                                'name': 8,
                                'childs': []
                            }
                        ]
                    }
                ]
            },
            {
                'name': 3,
                'childs': [
                    {
                        'name': 6,
                        'childs': [
                            {
                                'name': 9,
                                'childs': []
                            },
                            {
                                'name': 10,
                                'childs': []
                            }
                        ]
                    },
                    {
                        'name': 7,
                        'childs': []
                    }
                ]
            }
        ]
    }

    with open('simple_xml_output.xml', 'w') as file:
        file.write(dumps(tree, 2, '\n'))

def dumps(tree, indent=4, line_break='\n'):
    """
    DUMPS
    """

    delta_indent = ' ' * indent
    res = []
    def rec_dumps(node, spaces):
        """
        REC_DUMPS
        """

        nonlocal res

        res.append('{}<{}>{}'.format(spaces, node['name'], line_break))
        for child in node['childs']:
            rec_dumps(child, spaces + delta_indent)
        res.append('{}</{}>{}'.format(spaces, node['name'], line_break))

    rec_dumps(tree, '')
    return ''.join(res)

def loads(text):
    """
    LOADS
    """

    index = 0
    length = len(text)
    stack = []

    def ignore_whitespaces():
        """
        IGNORE_WHITESPACES
        """

        nonlocal index
        whitespaces = [' ', '\t', '\n', '\r']
        while index < length and text[index] in whitespaces:
            index += 1

    def read_tag():
        """
        READ_TAG
        """

        nonlocal index

        start_index = index
        while index < length and text[index] not in ['>']:
            index += 1

        assert index < length

        return text[start_index:index]

    def rec_loads():
        """
        REC_LOADS
        """

        nonlocal index
        nonlocal stack

        ignore_whitespaces()
        if index >= length:
            return

        assert text[index] == '<'
        index += 1

        # end tag
        if text[index] == '/':
            index += 1
            tag = read_tag()
            childs = []
            while len(stack) > 0 and stack[-1]['name'] != tag:
                childs.append(stack.pop())

            assert len(stack) > 0
            stack[-1]['childs'] = reversed(childs)

        else:
            stack.append({
                'name': read_tag(),
                'childs': []
            })

        index += 1
        rec_loads()

    rec_loads()
    return stack.pop()


if __name__ == '__main__':
    main()
    