"""
TEST_YZYAML tests `yzyaml` module
"""
from pprint import pprint
import unittest
import yzyaml

class TestYZYaml(unittest.TestCase):
    """
    TESTYZYAML tests `YZYaml` class
    """

    def test_dumps(self):
        """
        TEST_DUMPS tests `dumps` function
        """

        obj = {
            "Name": "BoBo",
            "Age": 30,
            "Married": True,
            "Children": [
                {
                    "Name": "KoKo",
                    "Age": 5
                },
                {
                    "Name": "LoLo",
                    "Age": 3
                }
            ],
            "Code": None
        }

        actual = yzyaml.YZYaml.dumps(obj)
        print(actual)

        expected = '''\
---
Children:
    - Name: KoKo
      Age: 5
    - Name: LoLo
      Age: 3
Name: BoBo
Married: True
Code:
Age: 30'''

        self.assertEqual(actual, expected)

if __name__ == '__main__':
    unittest.main()
