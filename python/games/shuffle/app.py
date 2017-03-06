"""
APP implements `shuffle games`
"""
from random import shuffle

def main():
    """
    MAIN
    """

    # params
    filenames = [
        './data/a.txt',
        './data/b.txt'
    ]


    # read
    table = [\
        [line.strip() for line in open(filename) if line.strip() != '']\
        for filename in filenames\
    ]

    # shuffle
    for col in table:
        shuffle(col)

    # lines
    rows = min(len(col) for col in table)
    cols = len(table)
    lines = []
    for row in range(rows):
        line = ''
        for col in range(cols):
            line += table[col][row] + ' '
        lines.append(line)


    # write
    with open('result.txt', 'w') as file:
        for line in lines:
            file.write(line + '\n\n')

if __name__ == '__main__':
    main()

