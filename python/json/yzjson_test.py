"""
YZJSON_TEST tests 'yzjson' module
"""
from pprint import pprint
from yzjson import YZJson

class YZJsonTest(object):
    """
    YZJSONTEST tests 'YZJson' class
    """

    @staticmethod
    def run():
        """
        RUN runs all tests
        """
        return all([
            YZJsonTest.typeof_test01(),\
            YZJsonTest.dump_test01(),\
            YZJsonTest.loads_test01(),\
            YZJsonTest.validate_test01()
        ])

    @staticmethod
    def dump_test01():
        """
        DUMP_TEST01 tests 'dump' function
        """
        obj = {
            'name': 'Yasin',
            'age': 10
        }

        actual = YZJson.dump(obj)

        expected = """\
{
    "age": 10,
    "name": "Yasin"
}"""

        return actual == expected

    @staticmethod
    def typeof_test01():
        """
        TYPEOF_TEST01 tests 'typeof' function
        """

        actual = YZJson.typeof({'name': 'Yasin'})
        expected = "object"

        return actual == expected

    @staticmethod
    def loads_test01():
        """
        LOADS_TEST01 tests 'loads' function
        """
        text =\
        """
        {
            "name": "BoBo",
            "age": 30,
            "maried": true,
            "children": ["LoLo", "KoKo"],
            "code": null
        }
        """
        actual = YZJson.loads(text)
        expected = {
            "name": "BoBo",
            "age": 30.0,
            "maried": True,
            "children": ["LoLo", "KoKo"],
            "code": None
        }

        pprint(actual)
        pprint(expected)
        return actual == expected

    @staticmethod
    def validate_test01():
        """
        VALIDATE_TEST01 tests 'validate' function
        """

        jtext =\
        """
        {
            "name": "BoBo",
            "age": 30,
            "maried": true,
            "children": ["LoLo", "KoKo"],
            "code": null
        }
        """
        jschema =\
        """
        {
            "type": "object",
            "properties": {
                "name": {
                    "type": "string"
                },
                "age": {
                    "type": "number"
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
        """

        actual = YZJson.validate(jtext, jschema)
        expected = True

        return actual == expected

if __name__ == '__main__':
    print(YZJsonTest.run())
        