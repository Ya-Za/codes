"""
TESTS
"""
import unittest
from ndarray_ import NDArray


class NDArrayTest(unittest.TestCase):
    """
    NDARRAYTEST
    """

    def test_size(self):
        """
        TEST_SIZE
        """
        array = NDArray([1, 2, 3, 4], (2, 2))

        # get
        actual = array.size
        expected = 4
        self.assertEqual(actual, expected)

        # set
        with self.assertRaises(AttributeError):
            array.size = 4

    def test_shape(self):
        """
        TEST_SHAPE
        """
        array = NDArray([1, 2, 3, 4, 5, 6], (2, 3))

        # get
        actual = array.shape
        expected = (2, 3)
        self.assertEqual(actual, expected)

        # set
        with self.assertRaises(ValueError):
            array.shape = (2, 2)

    def test_get_cumsize(self):
        """
        TEST_GET_CUMSIZE
        """
        array = NDArray(list(range(12)), (2, 3, 2))
        actual = array.get_cumsize()
        expected = [6, 2, 1]
        self.assertEqual(actual, expected)

    def test_get_index(self):
        """
        TEST_GET_INDEX
        """
        array = NDArray(list(range(12)), (2, 3, 2))
        actual = array.get_index([1, 2, 1])
        expected = 11
        self.assertEqual(actual, expected)

    def test___getitem__(self):
        """
        TEST___GETITEM__
        """
        array = NDArray(list(range(12)), (2, 3, 2))
        actual = array[1, 2, 1]
        expected = 11
        self.assertEqual(actual, expected)

    def test___setitem__(self):
        """
        TEST___SETITEM__
        """
        array = NDArray(list(range(12)), (2, 3, 2))
        array[1, 2, 1] = 0
        actual = array[1, 2, 1]
        expected = 0
        self.assertEqual(actual, expected)

    def test_str_to_pair(self):
        """
        TEST_STR_TO_PAIR
        """
        size = 10

        # number
        str_ = '1'
        actual = NDArray.str_to_pair(str_, size)
        expected = (1, 1)
        self.assertEqual(actual, expected)

        # :
        str_ = ':'
        actual = NDArray.str_to_pair(str_, size)
        expected = (0, 9)
        self.assertEqual(actual, expected)

        # number:
        str_ = '1:'
        actual = NDArray.str_to_pair(str_, size)
        expected = (1, 9)
        self.assertEqual(actual, expected)

        # :number
        str_ = ':1'
        actual = NDArray.str_to_pair(str_, size)
        expected = (0, 1)
        self.assertEqual(actual, expected)

        # number:number
        str_ = '1:2'
        actual = NDArray.str_to_pair(str_, size)
        expected = (1, 2)
        self.assertEqual(actual, expected)

        # -number
        str_ = '-1'
        actual = NDArray.str_to_pair(str_, size)
        expected = (9, 9)
        self.assertEqual(actual, expected)

    def test_query_to_pairarray(self):
        """
        TEST_QUERY_TO_PAIRARRAY
        """
        array = NDArray(list(range(12)), (2, 3, 2))
        query = '1, 1:2, :'
        actual = array.query_to_pairarray(query)
        expected = [(1, 1), (1, 2), (0, 1)]
        self.assertEqual(actual, expected)

    def test_get_shape(self):
        """
        TEST_GET_SHAPE
        """
        pairarray = [(1, 1), (1, 3)]
        actual = NDArray.get_shape(pairarray)
        expected = (3, )
        self.assertEqual(actual, expected)

    def test_get_subarray(self):
        """
        TEST_GET_SUBARRAY
        """
        array = NDArray(list(range(12)), (2, 3, 2))
        query = '1, 1:2, :'
        actual = array.get_subarray(query)
        expected = NDArray([8, 9, 10, 11], (2, 2))
        self.assertEqual(actual, expected)

    def test___str__(self):
        """
        TEST___STR__
        """
        array = NDArray(list(range(12)), (2, 3, 2))
        actual = str(array)
        expected = str(array)

        print(array)
        self.assertTrue(actual, expected)

if __name__ == '__main__':
    unittest.main()
