"""
YZJSON module simulates 'json' module
"""
import json

def main():
    """
    MAIN implements main function
    """
    obj = {
        'name': ['Yuri', 'Goori'],
        'ismarried': True,
        'childs': [
            {
                'name': 'yoyo',
                'age': 10
            },
            {
                'name': 'bobo',
                'age': None
            }
        ]
    }

    YZJson.dump(obj)
    # print(json.dumps(obj, indent=4))

class YZJson(object):
    """
    YZJSON implements 'json' class
    """

    @staticmethod
    def dump(obj, indent=4):
        """
        DUMP convert an valid json object to a str

        Parameters
        ----------
        - obj: 'dict', 'list', 'str', 'number', 'bool' or 'null'
            input valid json object
        - indent: int (default=4)
            number of spaces for each indentation step

        Returns
        -------
        - : str
            json string

        Examples
        --------
        1.
            >>> obj = {
                'name': 'yasin',
                'age': 10
            }
            >>> YZJson.dump(obj)
            {
                "name": "yasin",
                "age": 10
            }
        """
        deltatab = ' ' * indent

        res = []

        def rec_dump(obj, tab, noindent):
            """
            REC_DUMP implements recursive-dump

            Parameters
            ----------
            - obj: 'dict', 'list', 'str', 'number', 'bool' or 'null'
                input valid json object
            - tab: str
                tab string
            - noindent: bool
                if true, 'tab' should not be added
            """

            if YZJson.typeof(obj) == "object":
                if noindent:
                    res.append("{\n")
                else:
                    res.append(tab + "{\n")

                keys = list(obj.keys())
                values = list(obj.values())
                for i in range(len(keys) - 1):
                    res.append(tab + deltatab + '"' + keys[i] + '": ')
                    rec_dump(values[i], tab + deltatab, True)
                    res.append(",\n")

                res.append(tab + deltatab  + '"' + keys[-1] + '": ')
                rec_dump(values[-1], tab + deltatab, True)
                res.append("\n")

                res.append(tab + "}")

            if YZJson.typeof(obj) == "array":
                if noindent:
                    res.append("[\n")
                else:
                    res.append(tab + "[\n")

                for i in range(len(obj) - 1):
                    rec_dump(obj[i], tab + deltatab, False)
                    res.append(",\n")

                rec_dump(obj[-1], tab + deltatab, False)
                res.append("\n")

                res.append(tab + "]")

            if YZJson.typeof(obj) == "string":
                if noindent:
                    res.append('"' + obj + '"')
                else:
                    res.append(tab + '"' + obj + '"')

            if YZJson.typeof(obj) == "number":
                if noindent:
                    res.append(str(obj))
                else:
                    res.append(tab + str(obj))

            if YZJson.typeof(obj) == "bool":
                if noindent:
                    res.append(str(obj))
                else:
                    res.append(tab + str(obj))

            if YZJson.typeof(obj) == "null":
                if noindent:
                    res.append("null")
                else:
                    res.append(tab + "null")

        rec_dump(obj, '', True)

        return ''.join(res)

    @staticmethod
    def typeof(obj):
        """
        TYPEOF returns type of input object

        Parameters
        ----------
        - obj: 'dict', 'list', 'str', 'number', 'bool' or 'null'
            input valid json object

        Returns
        -------
        - : str
            string type

        Examples
        --------
        1.
            >>> YZJson.typeof({'name': 'Yasin'})
            "object"
        2.
            >>> YZJson.typeof([1, 2, 3])
            "array"
        3.
            >>> YZJson.typeof("Yasin")
            "string"
        4.
            >>> YZJson.typeof(1.2)
            "number"
        5.
            >>> YZJson.typeof(true)
            "boolean"
        6.
            >>> YZJson.typeof(null)
            "null"
        7.
            >>> YZJson.typeof(set())
            "undefined"
        """

        if isinstance(obj, dict):
            return 'object'
        if isinstance(obj, list):
            return 'array'
        if isinstance(obj, str):
            return 'string'
        if isinstance(obj, int):
            return 'number'
        if isinstance(obj, float):
            return 'number'
        if isinstance(obj, bool):
            return 'boolean'
        if obj is None:
            return 'null'

        return 'undefined'

    @staticmethod
    def loads(text):
        """
        Parameters
        ----------
        - text: str
            input json string

        Returns
        -------
        - dict|array|str|float|bool|None

        Examples
        --------
        1.
            >>> text =\
            '''
            {
                "name": "BoBo",
                "age": 30,
                "maried": true,
                "children": ["LoLo", "KoKo"],
                "code": null
            }
            '''
            >>> YZJson.loads(text)
            {
                "name": "BoBo",
                "age": 30,
                "maried": True,
                "children": ["LoLo", "KoKo"],
                "code": None
            }
        """

        index = 0
        text_lenght = len(text)

        def ignore_whitespaces():
            r"""
            IGNORE_WHITESPACES ignores \s and advances nonlocal index
            """

            nonlocal index
            whitespaces = [' ', '\t', '\r', '\n']
            while index < text_lenght and text[index] in whitespaces:
                index += 1

            if index == text_lenght:
                raise Exception("ignore_whitespaces::Can't read value")

        def read_literal(literal):
            """
            READ_LITERAL reads and returns literal

            Parameters
            ----------
            - literal: str
                input literal

            Returns
            -------
            - str
                read literal
            """

            nonlocal index
            if index + len(literal) > text_lenght:
                raise Exception("read_literal::Can't read literal")

            if text[index:index + len(literal)] != literal:
                raise Exception("read_literal::Can't read literal")

            index += len(literal)
            return literal

        def read_digits():
            """
            READ_DIGITS reads and returns digits
            """

            nonlocal index
            digit = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
            previous_index = index
            while index < text_lenght and text[index] in digit:
                index += 1

            return text[previous_index:index]

        def read_number():
            """
            READ_NUMBER reads and returns number
            """

            nonlocal index
            number = []
            # -
            if index < text_lenght and text[index] == '-':
                number.append('-')
                index += 1
            # int
            number.append(read_digits())
            # frac -> . digits
            # - .
            if index < text_lenght and text[index] == '.':
                number.append('.')
                index += 1
                # - digits
                number.append(read_digits())
            # exp
            if index < text_lenght and text[index] in ['e', 'E']:
                number.append(text[index])
                index += 1
                if index < text_lenght and text[index] in ['+', '-']:
                    number.append(text[index])
                    index += 1
                number.append(read_digits())

            return float(''.join(number))

        def read_string():
            """
            READ_STRING reads and returns string
            """

            nonlocal index
            previous_index = index
            while index < text_lenght and (text[index] != '"' or text[index - 1] == '\\'):
                index += 1

            if index == text_lenght:
                raise Exception("read_string::Can't read string")

            # ignore "
            index += 1
            return text[previous_index: index - 1]

        def read_value():
            """
            READ_VALUE reads and returns value(dict|list|str|float|bool|None)
            """

            nonlocal index
            obj = None
            ignore_whitespaces()
            # object
            if text[index] == '{':
                index += 1
                obj = dict()

                while True:
                    ignore_whitespaces()
                    read_literal('"')
                    prop = read_string()
                    ignore_whitespaces()
                    read_literal(':')
                    obj[prop] = read_value()
                    ignore_whitespaces()
                    if text[index] == '}':
                        index += 1
                        break
                    if text[index] != ',':
                        raise Exception("read_value::Can't read object")
                    index += 1
            # array
            elif text[index] == '[':
                index += 1
                obj = list()

                while True:
                    obj.append(read_value())
                    if text[index] == ']':
                        index += 1
                        break
                    if text[index] != ',':
                        raise Exception("read_value::Can't read object")
                    index += 1

            # string
            elif text[index] == '"':
                index += 1
                obj = read_string()

            # bool
            elif text[index] == 't':
                obj = bool(read_literal('true'))
            elif text[index] == 'f':
                obj = bool(read_literal('false'))

            # null
            elif text[index] == 'n':
                read_literal('null')

            # number
            else:
                obj = read_number()

            return obj


        return read_value()

    @staticmethod
    def validate(jtext, jschema):
        """
        VALIDATE validates json-text with json-schema

        Parameters
        ----------
        - jtext: str
            input json-string
        - jschema: str
            json-schema

        Returns
        -------
        - bool
            validation result

        Examples
        --------
        1.
            >>> jtext =\
            '''
            {
                "name": "BoBo",
                "age": 30,
                "maried": true,
                "children": ["LoLo", "KoKo"],
                "code": null
            }
            '''
            >>> jschema =\
            '''
            {
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string"
                    },
                    "age": {
                        "type": "integer"
                    },
                    "married": {
                        "type": "boolean"
                    },
                    "children": {
                        "type": "array",
                        "items": {
                            "type": "string"
                        }
                    },
                    "code": {
                        "type": "string"
                    }
                }
            }
            '''

            >>> YZJson.validate(jtext, jschema)
            True
        """

        obj = json.loads(jtext)
        obj_schema = json.loads(jschema)

        def rec_validate(obj, obj_schema):
            """
            REC_VALIDATE recursively validates object with object-schema

            Parameters
            ----------
            - obj: object
                input object
            - obj_schema: object
                object schema

            Returns
            -------
            - bool
                validation result
            """

            if YZJson.typeof(obj) is 'null':
                return True

            if YZJson.typeof(obj) != obj_schema['type']:
                return False

            if obj_schema['type'] == 'object':
                for key in obj.keys():
                    if key in obj_schema['properties'].keys():
                        if not rec_validate(obj[key], obj_schema['properties'][key]):
                            return False
                return True

            if obj_schema['type'] == 'array':
                for item in obj:
                    if not rec_validate(item, obj_schema['items']):
                        return False
                return True

            return True

        return rec_validate(obj, obj_schema)


if __name__ == '__main__':
    main()