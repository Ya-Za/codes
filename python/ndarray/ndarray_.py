"""
NDARRAY_ implements `ndarray`
"""
import re
import itertools


def main():
    """
    MAIN
    """
    print('Hello, World!')


class NDArray(object):
    """
    NDARRAY
    """

    def __init__(self, array, shape):
        self.__array = array
        self.__shape = shape
        self.__cumsize = self.get_cumsize()

    @property
    def size(self):
        """
        SIZE
        """
        return len(self.__array)

    @size.setter
    def size(self, _):
        """
        SIZE
        """
        raise AttributeError('attribute `size` is not writable')

    @property
    def shape(self):
        """
        SHAPE
        """
        return self.__shape

    @shape.setter
    def shape(self, value):
        """
        SHAPE
        """
        new_size = 1
        for item in value:
            new_size *= item

        if self.size != new_size:
            raise ValueError('`size` of new array must be unchanged')

        self.__shape = value
        self.__cumsize = self.get_cumsize()

    @property
    def ndim(self):
        """
        NDIM
        """
        return len(self.shape)

    @ndim.setter
    def ndim(self, _):
        """
        NDIM
        """
        raise AttributeError('attribute `ndim` is not writable')

    def get_cumsize(self):
        """
        GET_CUMSIZE
        """
        cumsize = [1] * self.ndim
        for i in range(self.ndim - 2, -1, -1):
            cumsize[i] = cumsize[i + 1] * self.shape[i + 1]

        return cumsize

    def get_index(self, indeces):
        """
        GET_INDEX
        """
        total_index = 0
        for i, (index, size, cumsize) in enumerate(zip(indeces, self.shape, self.__cumsize)):
            if index >= size:
                raise IndexError(
                    'index {} is out of bounds for axis {} with size {}'
                    .format(index, i, size)
                )
            total_index += index * cumsize

        return total_index

    def __getitem__(self, indeces):
        if len(indeces) != self.ndim:
            raise IndexError('too many indices for array')

        return self.__array[self.get_index(indeces)]

    def __setitem__(self, indeces, item):
        if len(indeces) != self.ndim:
            raise IndexError('too many indices for array')

        self.__array[self.get_index(indeces)] = item

    # todo: define `array` property
    def __eq__(self, other):
        return self.__array == other.__array and self.shape == other.shape

    def __str__1(self):
        res = []
        query = ','.join([':'] * self.ndim)
        pairarray = self.query_to_pairarray(query)
        pairarray = pairarray[:-1]
        indeces = [list(range(begin_index, end_index + 1))
                   for begin_index, end_index in pairarray]

        indeces = itertools.product(*indeces)

        for index in indeces:
            query = str(list(index))
            query = query[1:-1]
            query += ', :'
            array = self.get_subarray(query)
            res.append('(' + query + ') : ' + str(array.__array))

        return '\n'.join(res)

    def __str__(self):
        res = ['\n\n']

        def str_rec(index):
            """
            STR_REC
            """
            length = len(index)
            if length == self.ndim:
                res.append(str(self.__getitem__(index)))
                return

            # spaces
            if length > 0 and index[-1] > 0:
                res.append(' ' * length)

            # `[`
            res.append('[')

            # [0, end)
            size = self.shape[length] - 1
            for item in range(size):
                str_rec(index + [item])
                # `,` and `\n`
                res.append(', ')
                res.append('\n' * (self.ndim - length - 1))

            # end
            str_rec(index + [size])

            # `]`
            res.append(']')

        str_rec([])
        return ''.join(res)

    @staticmethod
    def str_to_pair(str_, size):
        """
        STR_TO_PAIR
        """
        begin_index, end_index = 0, size - 1

        if str_.find(':') == -1:
            begin_index = int(str_)
            end_index = begin_index
        elif str_ != ':':
            match = re.match(r'(?P<begin>-?\d+)\s*:$', str_)
            if match is not None:
                begin_index = int(match.group('begin'))
            else:
                match = re.match(r':\s*(?P<end>-?\d+)', str_)
                if match is not None:
                    end_index = int(match.group('end'))
                else:
                    match = re.match(
                        r'(?P<begin>-?\d+)\s*:\s*(?P<end>-?\d+)', str_)
                    if match is not None:
                        begin_index = int(match.group('begin'))
                        end_index = int(match.group('end'))
                    else:
                        raise ValueError('pattern is not correct')

        if begin_index < 0:
            begin_index += size
        if end_index < 0:
            end_index += size

        return (begin_index, end_index)

    def query_to_pairarray(self, query):
        """
        QUERY_TO_PAIRARRAY
        """
        pairs = [item.strip() for item in query.split(',')]
        assert len(pairs) == self.ndim

        return [NDArray.str_to_pair(item, self.shape[index]) for index, item in enumerate(pairs)]

    # todo: must be private
    @staticmethod
    def get_shape(pairarray):
        """
        GET_SHAPE
        """
        return tuple((end_index - begin_index) + 1
                     for begin_index, end_index in pairarray if end_index > begin_index)

    def get_subarray(self, query):
        """
        GET_SUBARRAY
        """
        pairarray = self.query_to_pairarray(query)

        indeces = [list(range(begin_index, end_index + 1))
                   for begin_index, end_index in pairarray]

        array = [self.__getitem__(index)
                 for index in itertools.product(*indeces)]
        shape = self.get_shape(pairarray)

        return NDArray(array, shape)


if __name__ == '__main__':
    main()
