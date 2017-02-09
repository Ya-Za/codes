"""
LYNDASUB generates subtitle for `lynda.com` video tutorials
"""

import request
from lxml import etree

class LyndaSub(object):
    """
    LYNDASUB generates subtitle for `lynda.com` video tutorials
    """

    def __init__(self, url):
        """
        Parameters
        ----------
        - url: str
            url of `lynda.com` video
        """

        self.url = url
        self.__path = {
            'title': '//*[@id="course-page"]/div[1]/div/div/div[1]/h1/text()'
        }

    def get_html(self, url):
        """
        GET_HTML gets html

        Returns
        -------
        - : lxml.etree.Element
        """
        return etree.HTML(\
            requests.get(url).content\
        )

    def get_title(self):
        """
        GET_TITLE gets title of course

        Returns
        -------
        - : str
            title of course
        """
        return self.html.xpath(self.__path['title'])[0]

