"""
YZ_PATH_TEST tests 'yz_path' module
"""
import yz_path

def main():
    """
    MAIN function
    """
    print(all([\
        get_dirs_files_test01(),\
        walk_test_01()\
    ]))

def get_dirs_files_test01():
    """
    GET_DIRS_FILES_TEST01 tests yz_path.get_dirs_files()
    """
    root = r'./folder01'
    actual = yz_path.get_dirs_files(root)
    expected = (['folder02'], ['file_01_01.txt', 'file_01_02.txt', 'file_01_03.pdf'])

    return actual == expected


def walk_test_01():
    """
    WALK_TEST tests yz_path.walk()
    """
    root = r'./folder01'
    actual = list(yz_path.walk(root))

    expected = [\
        (\
            './folder01',
            ['folder02'],
            ['file_01_01.txt', 'file_01_02.txt', 'file_01_03.pdf']\
        ),
        (\
            './folder01\\folder02',
            [],
            ['file_02_01.txt']\
        )\
    ]

    return actual == expected

if __name__ == '__main__':
    main()
