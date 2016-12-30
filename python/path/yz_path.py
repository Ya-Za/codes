"""
YZ_PATH try to implement os.path functionalities
"""
from pprint import pprint
import os

def main():
    """
    MAIN function
    """
    root = r'./folder01'
    # res = []
    # for path, subdirs, files in walk(root):
    #     res.append(path)
    #     res.append(subdirs)
    #     res.append(files)

    res = list(walk(root))

    pprint(res)

def get_dirs_files(root):
    """
    GET_DIRS_FILES get 'directory names' and 'file names' of given root directory
    """
    dirs_files = os.listdir(root)

    dirs = [\
        dir\
        for dir in dirs_files\
        if os.path.isdir(os.path.join(root, dir))\
    ]

    files = [\
        file\
        for file in dirs_files\
        if os.path.isfile(os.path.join(root, file))\
    ]

    return dirs, files

def walk(root):
    """
    WALK implements os.walk
    """
    dirs, files = get_dirs_files(root)
    yield root, dirs, files

    for dir_ in dirs:
        yield from walk(os.path.join(root, dir_))

if __name__ == '__main__':
    main()
