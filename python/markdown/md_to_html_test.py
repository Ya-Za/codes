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
            MdToHtmlTest.headings_test_02(),\
            MdToHtmlTest.get_references_test_01(),\
            MdToHtmlTest.links_test_01(),\
            MdToHtmlTest.images_test_01(),\
            MdToHtmlTest.ref_links_test_01(),\
            MdToHtmlTest.ref_images_test_01()\
        ])

    @staticmethod
    def headings_test_01():
        """
        HEADINGS_TEST_01 tests MdToHtml.headings()
        """
        mth = MdToHtml('# heading1 \n## heading2')
        mth.headings()
        actual = mth.text

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

        expected = '<h1>heading1</h1>'

        return actual == expected

    @staticmethod
    def get_references_test_01():
        """
        GET_REFERENCES_TEST_01 tests MdToHtml.get_references()
        """

        mth = MdToHtml('text\n[site1]: www.google.com "google"')
        mth.get_references()
        actual_reference = mth.references
        expected_reference =\
        {
            'site1': {
                'url': 'www.google.com',
                'title': 'google'
            }
        }

        actual_text = mth.text
        expected_text = 'text\n'

        return\
            actual_reference == expected_reference and\
            actual_text == expected_text

    @staticmethod
    def links_test_01():
        """
        LINKS_TEST_01 tests MdToHtml.links()
        """

        mth = MdToHtml('text [link](www.google.com) text')
        mth.links()
        actual = mth.text
        expected = 'text <a href="www.google.com">link</a> text'

        return actual == expected

    @staticmethod
    def images_test_01():
        """
        IMAGES_TEST_01 tests MdToHtml.images_test_01()
        """

        mth = MdToHtml('text ![description](www.google.com/image.png) text')
        mth.images()
        actual = mth.text
        expected = 'text <img alt="description" src="www.google.com/image.png"> text'

        return actual == expected

    @staticmethod
    def ref_links_test_01():
        """
        REF_LINKS_TEST_01 tests MdToHtml.ref_links()
        """

        mth = MdToHtml('text [link][site1]\n[site1]: www.google.com "google"')
        mth.get_references()
        mth.ref_links()
        actual = mth.text
        expected = 'text <a href="www.google.com" title="google">link</a>\n'

        return actual == expected

    @staticmethod
    def ref_images_test_01():
        """
        REF_IMAGES_TEST_01 tests MdToHtml.ref_images()
        """

        mth = MdToHtml(\
            'text ![description][image1]\n[image1]: www.google.com/google.png "google"'\
        )
        mth.get_references()
        mth.ref_images()
        actual = mth.text
        references = 'text <img alt="description" src="www.google.com/google.png" title="google">\n'

        return actual == references

if __name__ == '__main__':
    main()
