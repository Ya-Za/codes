"""
MD_TO_HTML_TEST tests module 'md_to_html_test.py'
"""
from pprint import pprint
from md_to_html import MdToHtml

def main():
    """
    MAIN function
    """
    print(MdToHtmlTest.run())

class MdToHtmlTest(object):
    """
    MDTOHTMLTEST tests 'MdToHtml' class
    """
    @staticmethod
    def run():
        """
        RUN runs tests
        """
        return all([
            MdToHtmlTest.headings_test_01(),\
            MdToHtmlTest.headings_test_02()\
        ])

    @staticmethod
    def headings_test_01():
        """
        HEADINGS_TEST_01 tests MdToHtml.headings()
        """
        mth = MdToHtml('# heading1 \n## heading2')
        mth.headings()
        actual = mth.text
        pprint(actual)

        expected = '<h1>heading1</h1>\n<h2>heading2</h2>'

        return actual == expected

    @staticmethod
    def headings_test_02():
        """
        HEADINGS_TEST_02 tests MdToHtml.headings()
        """
        mth = MdToHtml('# heading1 ## ')
        mth.headings()
        actual = mth.text
        pprint(actual)

        expected = '<h1>heading1</h1>'

        return actual == expected

if __name__ == '__main__':
    main()
