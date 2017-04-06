"""
APP.PY implements `text alignment`, `nd array`
"""


def main():
    """
    MAIN
    """
    # # print_table
    # table = [
    #     ['name', 'age', 'red code'],
    #     ['ali', '10', 'aabc123'],
    #     ['hassan', '7788', 'cd1'],
    #     ['taghi ali', '321', '447']
    # ]

    # print_table(table, alignment='right')

    array = [[1, 2], [3, 4]]
    print(ndarray_to_string(array))


def text_align(text, max_length, alignment='left', filler=' '):
    """
    TEXT_ALIGN
    """
    if max_length <= len(text):
        return text

    number_of_spaces = max_length - len(text)

    if alignment == 'left':
        return text + (filler * number_of_spaces)

    if alignment == 'right':
        return (filler * number_of_spaces) + text

    if alignment == 'center':
        left_part = number_of_spaces // 2
        right_part = number_of_spaces - left_part
        return (filler * left_part) + text + (filler * right_part)


def print_table(table, alignment='left', seperator='|', filler=' '):
    """
    PRINT_TABLE
    """
    # max_length
    number_of_rows = len(table)
    number_of_cols = len(table[0])

    max_length = []
    for cindex in range(number_of_cols):
        col = []
        for rindex in range(number_of_rows):
            col.append(table[rindex][cindex])

        max_length.append(max(len(item) + 2 for item in col))

    # alignment
    # - header
    table[0] = [text_align(item, max_length[cindex], 'center', filler)
                for cindex, item in enumerate(table[0])]
    # - rows
    for rindex in range(1, number_of_rows):
        table[rindex] = [
            text_align(item, max_length[cindex], alignment, filler)
            for cindex, item in enumerate(table[rindex])
        ]

    # print
    # - header
    header_text = seperator.join(table[0])
    print(header_text)
    print('-' * len(header_text))
    # - rows
    for rindex in range(1, number_of_rows):
        print(seperator.join(table[rindex]))


def ndarray_to_string(array):
    """
    NDARRAY_TO_STRING
    """
    res = []

    def ndarray_to_string_rec(obj):
        """
        NDARRAY_TO_STRING_REC
        """
        if not isinstance(obj, list):
            res.append(str(obj) + ' ')
            return

        res.append('[')
        for item in obj:
            ndarray_to_string_rec(item)
        res.append(']')

    ndarray_to_string_rec(array)
    return ''.join(res)


if __name__ == '__main__':
    main()
