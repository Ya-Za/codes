from pprint import pprint
import unittest
import yzxml


class TestYZXml(unittest.TestCase):

    def test_dumps(self):
        obj = {
            "tag": "object",
            "attribs": {
                "id": "1"
            },
            "elements": [
                {
                    "tag": "name",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "string",
                            "attribs": {},
                            "elements": [
                                "BoBo"
                            ]
                        }
                    ]
                },
                {
                    "tag": "age",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "number",
                            "attribs": {},
                            "elements": [
                                "10"
                            ]
                        }
                    ]
                },
                {
                    "tag": "married",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "boolean",
                            "attribs": {},
                            "elements": [
                                "True"
                            ]
                        }
                    ]
                },
                {
                    "tag": "children",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "array",
                            "attribs": {},
                            "elements": [
                                {
                                    "tag": "string",
                                    "attribs": {},
                                    "elements": [
                                        "KoKo"
                                    ]
                                },
                                {
                                    "tag": "string",
                                    "attribs": {},
                                    "elements": [
                                        "LoLo"
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }

        actual = yzxml.YZXml.dumps(obj)

        print(actual)

        expected =\
'''
<object id:"1">
    <name>
        <string>
            BoBo
        </string>
    </name>
    <age>
        <number>
            10
        </number>
    </age>
    <married>
        <boolean>
            True
        </boolean>
    </married>
    <children>
        <array>
            <string>
                KoKo
            </string>
            <string>
                LoLo
            </string>
        </array>
    </children>
</object>
'''

        self.assertEqual(actual, expected)


    def test_loads(self):
        xtext =\
'''
<object id:"1">
    <name>
        <string>
            BoBo
        </string>
    </name>
    <age>
        <number>
            10
        </number>
    </age>
    <married>
        <boolean>
            True
        </boolean>
    </married>
    <children>
        <array>
            <string>
                KoKo
            </string>
            <string>
                LoLo
            </string>
        </array>
    </children>
</object>
'''

        actual = yzxml.YZXml.loads(xtext)

        expected = {
            "tag": "object",
            "attribs": {
                "id": "1"
            },
            "elements": [
                {
                    "tag": "name",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "string",
                            "attribs": {},
                            "elements": [
                                "BoBo"
                            ]
                        }
                    ]
                },
                {
                    "tag": "age",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "number",
                            "attribs": {},
                            "elements": [
                                "10"
                            ]
                        }
                    ]
                },
                {
                    "tag": "married",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "boolean",
                            "attribs": {},
                            "elements": [
                                "True"
                            ]
                        }
                    ]
                },
                {
                    "tag": "children",
                    "attribs": {},
                    "elements": [
                        {
                            "tag": "array",
                            "attribs": {},
                            "elements": [
                                {
                                    "tag": "string",
                                    "attribs": {},
                                    "elements": [
                                        "KoKo"
                                    ]
                                },
                                {
                                    "tag": "string",
                                    "attribs": {},
                                    "elements": [
                                        "LoLo"
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }

        self.assertDictEqual(actual, expected)

if __name__ == '__main__':
    unittest.main()
