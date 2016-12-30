"""
FIND_FILE_CONTENT module search string in file contents.
"""
from pprint import pprint
import os
import re

def main():
    """
    MAIN is test module
    """
    print(TestFCC.do_tests())

class FFC(object):
    """
    FFC Find File Contents
    """

    @staticmethod
    def find_files(root, pattern='.*'):
        """
        ex.1
        >>> root = './folder01'
        >>> FFC.find_files(root)
        [
            './folder01/file_01_01.txt',
            './folder01/file_01_02.txt',
            './folder01/file_01_03.pdf',
            './folder01/folder02/file_02_01.txt'
        ]

        ex.2
        >>> root = './folder01'
        >>> pattern = r'.*\.txt'
        >>> FFC.find_files(root, pattern)
        [
            './folder01/file_01_01.txt',
            './folder01/file_01_02.txt',
            './folder01/folder02/file_02_01.txt'
        ]
        """
        files = []
        pattern_obj = re.compile(pattern)
        for path, _, filenames in os.walk(root):
            for filename in filenames:
                if pattern_obj.match(filename) is not None:
                    files.append(os.path.join(path, filename).replace('\\', '/'))

        return files

    @staticmethod
    def find_file_contents(root, query, filename_pattern='.*'):
        """
        ex.1
        >>> root = './folder01'
        >>> query = 'yasin'
        >>> filename_pattern = r'.*\.txt'
        >>> FFC.find_file_contents(root, query, filename_pattern)
        [
            './folder01/file_01_02.txt',
            './folder01/folder02/file_02_01.txt'
        ]
        """
        files = FFC.find_files(root, filename_pattern)
        pattern_obj = re.compile(query)
        selected_files = [\
            file\
            for file in files\
            if pattern_obj.search(open(file).read(), re.IGNORECASE) is not None\
        ]

        return selected_files

class TestFCC(object):
    """
    TESTFCC test class of FCC
    """

    @staticmethod
    def do_tests():
        """
        DO_TESTS do all tests
        """
        return all([\
                TestFCC.find_files_test01(),\
                TestFCC.find_files_test02(),\
                TestFCC.find_file_contents_test01()\
        ])

    @staticmethod
    def find_files_test01():
        """
        FIND_FILE_TEST01 tests FCC.find_files_test()
        """
        root = './folder01'
        actual = FFC.find_files(root)

        expected = [
            './folder01/file_01_01.txt',
            './folder01/file_01_02.txt',
            './folder01/file_01_03.pdf',
            './folder01/folder02/file_02_01.txt'
        ]

        return actual == expected

    @staticmethod
    def find_files_test02():
        """
        FIND_FILE_TEST01 tests FCC.find_files_test()
        """
        root = './folder01'
        pattern = r'.*\.txt'
        actual = FFC.find_files(root, pattern)

        expected = [
            './folder01/file_01_01.txt',
            './folder01/file_01_02.txt',
            './folder01/folder02/file_02_01.txt'
        ]

        return actual == expected

    @staticmethod
    def find_file_contents_test01():
        """
        FIND_FILE_CONTENST_TEST01 tests FCC.find_file_contents()
        """
        root = './folder01'
        query = 'yasin'
        filename_pattern = r'.*\.txt'
        actual = FFC.find_file_contents(root, query, filename_pattern)

        expected = [
            './folder01/file_01_02.txt',
            './folder01/folder02/file_02_01.txt'
        ]

        return actual == expected


if __name__ == '__main__':
    main()
