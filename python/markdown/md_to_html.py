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
        self.references = {}

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

    def get_references(self):
        """
        GET_REFERENCES add '[reference] url title' to the self.references

        Examples
        --------
        1.
            >>> mth = MdToHtml('text\n[site1]: www.google.com "google"')
            >>> mth.references
            {
                'site1': {
                    'url': 'www.google.com',
                    'title': 'google'
                }
            }
            >>> mth.text
            'text\n'
        """
        pattern =\
        r"""
            ^[ \t]*                 # optional spaces at the begining
            \[(?P<ref>.+)\]:        # 'ref' group
            [ \t]+                  # spaces
            (?P<url>\S+)            # 'url' group
            [ \t]+                  # spaces
            (?:"(?P<title>.+)")?    # optional 'title' group
            [ \t]*$                 # optional spaces at the end
        """

        for match in re.finditer(pattern, self.text, re.MULTILINE | re.VERBOSE):
            self.references[match.group('ref')] = {\
                'url': match.group('url'),\
                'title': match.group('title') or ""\
            }

        # remove references
        self.text = re.sub(\
            re.compile(pattern, re.MULTILINE | re.VERBOSE),\
            '',\
            self.text\
        )

    def links(self):
        """
        LINKS converts '[text](address)' to '<a href="address">text</a>'

        Examples
        --------
        1.
            >>> mth = MdToHtml('text [link](www.google.com) text')
            >>> mth.links()
            >>> mth.text
            'text <a href="www.google.com">link</a> text'
        """

        pattern =\
        r"""
            \[(?P<link>.+)\]        # 'link' group
            \((?P<url>\S+)\)        # 'url' group
        """

        self.text = re.sub(\
            re.compile(pattern, re.MULTILINE | re.VERBOSE),\
            lambda m: '<a href="{}">{}</a>'.format(m.group('url'), m.group('link')),\
            self.text\
        )

    def ref_links(self):
        """
        REF_LINKS converts '[text][ref]\n[ref]: address "title"' to
            '<a href="address" title="title">text</a>'

        Examples
        --------
        1.
            >>> mth = MdToHtml('text [link][site1]\n[site1]: www.google.com "google"')
            >>> mth.get_references()
            >>> mth.ref_links()
            >>> mth.text
            'text <a href="www.google.com" title="google">link</a>\n'
        """

        pattern =\
        r"""
            \[(?P<link>.+)\]       # 'link' group
            \[(?P<ref>.+)\]        # 'ref' group
        """

        self.text = re.sub(\
            re.compile(pattern, re.MULTILINE | re.VERBOSE),\
            lambda m:\
                '<a href="{}" title="{}">{}</a>'.format(\
                    self.references[m.group('ref')]['url'],\
                    self.references[m.group('ref')]['title'],\
                    m.group('link')\
                ) if m.group('ref') in self.references else m.group(0),\
            self.text\
        )

    def images(self):
        """
        IMAGES converts '![text](address)' to '<img alt="text" src="address">'

        Examples
        --------
        1.
            >>> mth = MdToHtml('text ![description](www.google.com/image.png) text')
            >>> mth.images()
            >>> mth.text
            'text <img alt="description" src="www.google.com/image.png"> text
        """

        pattern =\
        r"""
            !\[(?P<alt>.+)\]        # 'alt' group
            \((?P<url>\S+)\)        # 'url' group
        """

        self.text = re.sub(\
            re.compile(pattern, re.MULTILINE | re.VERBOSE),\
            lambda m: '<img alt="{}" src="{}">'.format(m.group('alt'), m.group('url')),\
            self.text\
        )

    def ref_images(self):
        """
        REF_IMAGES converts '![text][ref]\n[ref]: address "title"' to
            '<img alt="text" src="address" title="title">text</a>'

        Examples
        --------
        1.
            >>> mth = MdToHtml(\
                'text ![description][image1]\n[image1]: www.google.com/google.png "google"'\
                )
            >>> mth.get_references()
            >>> mth.ref_images()
            >>> mth.text
            'text <img alt="description" src="www.google.com/google.png" title="google">\n'
        """

        pattern =\
        r"""
            !\[(?P<alt>.+)\]      # 'link' group
            \[(?P<ref>.+)\]       # 'ref' group
        """

        self.text = re.sub(\
            re.compile(pattern, re.MULTILINE | re.VERBOSE),\
            lambda m:\
                '<img alt="{}" src="{}" title="{}">'.format(\
                    m.group('alt'),\
                    self.references[m.group('ref')]['url'],\
                    self.references[m.group('ref')]['title']\
                ) if m.group('ref') in self.references else m.group(0),\
            self.text\
        )
