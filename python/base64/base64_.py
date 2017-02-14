"""
BASE64
"""
import codecs

def main():
    """
    MAIN
    """
    bytearray_ = bytearray(b'yasin')

    b64 = Base64.encode(bytearray_)
    # b64 = codecs.encode(bytearray_, 'base64')
    bytearray_ = Base64.decode(b64)
    print(bytearray_.decode('ascii'))
    print(b64)
    print(bytearray_.decode('ascii'))


class Base64():
    """
    BASE64
    """
    codes = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

    @staticmethod
    def bytearray_to_str(bytearray_, length):
        """
        BYTEARRAY_TO_STR
        """
        formatstr = '{0:0' + str(length) + 'b}'
        return ''.join(formatstr.format(byte) for byte in bytearray_)

    @staticmethod
    def split_str(str_, sublength, ignore_residula=False):
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

        if index < length and not ignore_residula:
            trailing_zero = '0' * (sublength - (length - index))
            res.append(str_[index:] + trailing_zero)

        return res

    @staticmethod
    def encode(bytearray_):
        """
        ENCODE
        """
        byte_str = Base64.bytearray_to_str(bytearray_, 8)
        splited_str = Base64.split_str(byte_str, 6)

        return ''.join(Base64.codes[int(item, 2)] for item in splited_str)

    @staticmethod
    def decode(str_):
        """
        DECODE
        """
        bytearray_ = [Base64.codes.index(ch) for ch in str_]
        byte_str = Base64.bytearray_to_str(bytearray_, 6)
        splited_str = Base64.split_str(byte_str, 8, True)

        return bytearray(int(item, 2) for item in splited_str)



if __name__ == '__main__':
    main()

