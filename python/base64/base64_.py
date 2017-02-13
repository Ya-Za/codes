"""
BASE64
"""
import codecs

def main():
    """
    MAIN
    """
    str_ = b'yasin'
    print(Base64.encode(str_))
    print(codecs.encode(b'yasin', 'base64'))


class Base64():
    """
    BASE64
    """
    codes = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

    @staticmethod
    def bytearray_to_str(bytearray_):
        """
        BYTEARRAY_TO_STR
        """
        return ''.join('{0:08b}'.format(byte) for byte in bytearray_)

    @staticmethod
    def split_str(str_, sublength):
        """
        SPLIT_STR
        """
        length = len(str_)

        res = []
        index = 0
        while True:
            if index + sublength < length:
                res.append(str_[index:index+sublength])
            else:
                break
            index += sublength

        if index < length:
            trailing_zero = '0' * (sublength - (length - index))
            res.append(str_[index:] + trailing_zero)

        return res

    @staticmethod
    def encode(bytearray_):
        """
        ENCODE
        """
        byte_str = Base64.bytearray_to_str(bytearray_)
        splited_str = Base64.split_str(byte_str, 6)

        return ''.join(Base64.codes[int(item, 2)] for item in splited_str)


if __name__ == '__main__':
    main()

