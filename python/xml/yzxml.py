"""
YZXML implements 'xml' module
"""

class YZXml(object):
    """
    YZXML implements 'xml' functionalities
    """

    @staticmethod
    def loads(xtext):
        """
        LOADS converts xml-text to xml-object

        Parameters
        ----------
        - xtext: str
            input xml-string

        Returns
        -------
        - dict
            object-xml contains {'tag': str, 'attribs': dict, 'elements': list}

        Examples
        --------
        1.
            >>> xtext = '<person id="1"><name>BoBo<name></person>'
            >>> YZXml.loads(xtext)
            {
                'tag': 'person',
                'attribs': {'id': '1'},
                'elements': [
                    {
                        'tag': 'name',
                        'attribs': {},
                        'elements': [
                            'BoBo'
                        ]
                    }
                ]
            }
        """

        class XmlLoads(object):
            """
            XMLLOADS implements 'YZXml.loads' functionality
            """

            def __init__(self, xtext):
                self.index = 0
                self.xtext = xtext
                self.length = len(xtext)
                self.stack = []

            def loads(self):
                """
                LOADS converts xml-string to object-string

                Returns
                -------
                - dict
                    object-xml contains {'tag': str, 'attribs': dict, 'elements': list}
                """

                self.ignore_whitespaces()

                if self.index >= self.length:
                    return

                if self.xtext[self.index] == '<':
                    self.index += 1

                    if self.xtext[self.index] == '/':
                        self.index += 1

                        tag = self.read_until('>')
                        self.index += 1

                        elements = []
                        while len(self.stack) > 0 and\
                            (isinstance(self.stack[-1], str) or self.stack[-1]['tag'] != tag):
                            elements.append(self.stack.pop())

                        assert len(self.stack) > 0

                        self.stack[-1]['elements'].extend(reversed(elements))

                    else:
                        self.ignore_whitespaces()
                        tag = self.read_until(' >')

                        attribs = {}
                        if self.xtext[self.index] != '>':
                            attribs = self.read_attribs()

                        self.index += 1
                        self.stack.append({'tag': tag, 'attribs': attribs, 'elements': []})
                else:
                    self.stack.append(self.read_until('<').strip())

                self.loads()


            def ignore_whitespaces(self):
                """
                IGNORE_WHITESPACES reads whitespaces and advances self.index
                """

                whitespaces = [' ', '\t', '\n', '\r']
                while self.index < self.length and self.xtext[self.index] in whitespaces:
                    self.index += 1

            def read_until(self, chars):
                """
                READ_UNTIL reads charaters and advances self.index
                unitl reaches any character in 'cahrs'

                Parameters
                ----------
                - chars: str
                    stoping characters
                """

                start_index = self.index

                while self.index < self.length and self.xtext[self.index] not in chars:
                    self.index += 1

                assert self.index < self.length

                return self.xtext[start_index:self.index]

            def read_attribs(self):
                """
                READ_ATTRIBS reads attributes of an elements
                """

                attribs = {}
                while self.index < self.length:
                    self.ignore_whitespaces()
                    if self.xtext[self.index] == '>':
                        break
                    name = self.read_until('=')
                    self.index += 1
                    self.read_until('"')
                    self.index += 1
                    value = self.read_until('"')
                    self.index += 1

                    attribs[name] = value

                return attribs

        xmlloads = XmlLoads(xtext)
        xmlloads.loads()
        return xmlloads.stack.pop()

    @staticmethod
    def dumps(obj, indent=4):
        """
        DUMPS converts xml-object to xml-text

        Parameters
        ----------
        - obj: dict
            input object-xml contains {'tag': str, 'attribs': dict, 'elements': list}
        - indent: int (default=4)
            number of indentation

        Returns
        -------
        - str
            output xml-string

        Examples
        --------
        1.
            >>> obj = {
                'tag': 'person',
                'attribs': {'id': '1'},
                'elements': [
                    {
                        'tag': 'name',
                        'attribs': {},
                        'elements': [
                            'BoBo'
                        ]
                    }
                ]
            }
            >>> YZXml.loads(xtext)
            "<person id="1">
                <name>
                    BoBo
                <name>
            </person>"
        """

        delta_indent = ' ' * indent
        res = []
        def rec_dumps(obj, spaces):
            """
            REC_DUMPS recursively converts xml-object to xml-string
            """

            nonlocal res

            if isinstance(obj, str):
                res.append('{}{}\n'.format(spaces, obj))
                return

            # begining tag
            res.append('{}<{}'.format(spaces, obj['tag']))

            # attribs
            for key, value in obj['attribs'].items():
                res.append(' {}:"{}"'.format(key, value))

            res.append('>\n')

            # elements
            for element in obj['elements']:
                rec_dumps(element, spaces + delta_indent)

            # ending tag
            res.append('{}</{}>\n'.format(spaces, obj['tag']))

        rec_dumps(obj, '')

        return ''.join(res)

