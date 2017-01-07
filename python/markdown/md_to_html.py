"""
MD_TO_HTML converts markdown to html
"""
import re

class MdToHtml(object):
    """
    MDTOHTML converts markdown to html
    """

    def __init__(self, text):
        """
        Parameters
        ----------
        - text : str
            Markdown text.
        """
        self.text = text

    def headings(self):
        """
        HEADINGS replaces #, ##, ... with <h1>, <h2>, ...

        Examples
        --------
        1.
            >>> mth = MdToHtml('# heading1 \n## heading2')
            >>> mth.formatting()
            >>> print(mth.text)
            <h1>heading1</h1>
            <h2>heading2</h2>
        2.
            >>> mth = MdToHtml('# heading1 ## ')
            >>> mth.formatting()
            >>> print(mth.text)
            <h1>heading1</h1>
        """

        for i in range(1, 7):
            hash_sequence = '#' * i

            """
            Pattern
            -------
            - ^#        begining '#'
            - .*        any charachter
            -           space
            - #+        '#'s
            - [ \t]*    optional spaces
            """
            pattern = r'^{} .*( #+[ \t]*)$'.format(hash_sequence)
            self.text = re.sub(\
                re.compile(pattern, re.MULTILINE),\
                lambda m: m.group(0)[:m.start(1)],\
                self.text\
            )

            """
            Pattern
            -------
            - ^#            begining #
            - [ \t]+        spaces
            - (.+[^ \t])    'enclosed text' which its end-character isn't space
            - [ \t]*        optional spaces
            - $             end of sentence
            """
            pattern = r'^{}[ \t]+(.+[^ \t])[ \t]*$'.format(hash_sequence)

            self.text = re.sub(\
                re.compile(pattern, re.MULTILINE),\
                lambda m: '<h{0}>{1}</h{0}>'.format(i, m.group(1)),\
                self.text\
            )

    def formatting(self):
        """
        FORMATING replaces *, **, ` with <em>, <strong>, <code>

        Examples
        --------
        1.
            >>> mth = MdToHtml('this is *italic*, **bold** and `inline code`.)
            >>> mth.formatting()
            >>> print(mth.text)
            this is <em>italic</em>, <strong>bold</strong> and <code>inline code</code>.
        """
        replacements = {\
            r'\*' : 'em',\
            r'\*\*' : 'strong',\
            '`' : 'code'\
        }
        for key, value in replacements.items():
            pattern = r'{0}(.+){0}'.format(key)
            self.text = re.sub(\
                pattern,\
                lambda m: '<{0}>{1}</{0}>'.format(value, m.group(1)),\
                self.text\
            )

    