"""
LYNDASUB generates subtitle for `lynda.com` video tutorials
"""
import json
import requests
import os
import shutil
from lxml import etree


def main():
    """
    MAIN funciton
    """

    url = 'https://www.lynda.com/D3-js-tutorials/D3-js-Essential-Training-Data-Scientists/504428-2.html'
    ls = LyndaSub(url)
    # ls.dumps('./course.json')
    ls.mkdir()

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
        self.html = None
        self.__path = {
            'title': '/html/head/meta[@property="og:title"]/@content',
            'content': '//*[@id="toc-content"]/ul',
            'chapter': '/li[{}]/div/div/h4/text()',
            'section': '/li[{}]/ul/li[{}]/div/div[1]/a',
            'transcript': '//*[@id="transcripts-container"]/div/div/div/div'
        }

    @staticmethod
    def get_html(url):
        """
        GET_HTML gets html

        Returns
        -------
        - : lxml.etree.Element
        """
        return etree.HTML(\
            requests.get(url).content\
        )

    def get_title_of_course(self):
        """
        GET_TITLE gets title of course

        Returns
        -------
        - : str
            title of course
        """
        return self.html.xpath(self.__path['title'])[0].strip()

    @staticmethod
    def get_number_of_items(element, path):
        """
        GET_NUMBER_OF_ITEMS returns number of target items

        Returns
        -------
        - : int
            Number of target items
        """
        return int(element.xpath('count({})'.format(path)))

    def get_number_of_chapters(self):
        """
        GET_NUMBER_OF_CHAPTERS returns number of chapters

        Returns
        -------
        - : int
            Number of chapters
        """

        return LyndaSub.get_number_of_items(
            self.html,
            self.__path['content'] + '/li'
        )

    def get_number_of_sections(self, chapter_number):
        """
        GET_NUMBER_OF_SECTIONS returns number of sections of given chapter

        Paramters
        ---------
        - chapter_number: int
            Number of chapter
        Returns
        -------
        - : int
            Number of chapters
        """

        return LyndaSub.get_number_of_items(
            self.html,
            self.__path['content'] + '/li[{}]/ul/li'.format(chapter_number)
        )

    def get_title_of_chapter(self, chapter_number):
        """
        GET_TITLE_OF_CHAPTER returns title of given chapter number

        Paramters
        ---------
        - chapter_number: int
            Number of chapter
        Returns
        -------
        - : str
            Title of given chapter number
        """

        return self.html.xpath(
            self.__path['content'] +
            self.__path['chapter'].format(chapter_number)
        )[0].strip()

    def get_title_of_section(self, chapter_number, section_number):
        """
        GET_TITLE_OF_SECTION returns title of given chapter and section number

        Paramters
        ---------
        - chapter_number: int
            Number of chapter
        - section_number: int
            Number of section
        Returns
        -------
        - : str
            Title of given chapter number
        """

        return self.html.xpath(
            self.__path['content'] +
            self.__path['section'].format(chapter_number, section_number) + '/text()'
        )[0].strip()

    def get_href_of_section(self, chapter_number, section_number):
        """
        GET_HREF_OF_SECTION returns href of given chapter and section number

        Paramters
        ---------
        - chapter_number: int
            Number of chapter
        - section_number: int
            Number of section

        Returns
        -------
        - : str
            href of given chapter number
        """

        return self.html.xpath(
            self.__path['content'] +
            self.__path['section'].format(chapter_number, section_number) + '/@href'
        )[0].strip()

    def get_transcript(self, chapter_number, section_number):
        """
        GET_TRANSCRIPT returns transcript of specific section

        Paramters
        ---------
        - chapter_number: int
            Number of chapter
        - section_number: int
            Number of section

        Returns
        -------
        - : str
            Transcript of specific section
        """

        html = LyndaSub.get_html(self.get_href_of_section(chapter_number, section_number))
        transcript = html.xpath(self.__path['transcript'])[0]
        return etree.tostring(transcript, method='text', encoding='unicode').strip()

    def get_course(self):
        """
        GET_JSON returns a `dict` based on `lyndasub_schema.json` file`

        Returns
        -------
        - : dict
            A `dict` based on `lyndasub_schema.json` file
        """

        self.html = LyndaSub.get_html(self.url)

        course = {
            'title': self.get_title_of_course(),
            'chapters': []
        }

        for chapter_number in range(1, self.get_number_of_chapters() + 1):
            course['chapters'].append({\
                'title': self.get_title_of_chapter(chapter_number),
                'sections': []\
                }\
            )

            for section_number in range(1, self.get_number_of_sections(chapter_number) + 1):
                course['chapters'][-1]['sections'].append({\
                        'title': self.get_title_of_section(chapter_number, section_number),\
                        'transcript': self.get_transcript(chapter_number, section_number)\
                    }\
                )

        return course

    def dumps(self, path):
        """
        DUMPS save course data in the given path

        Parameters
        ----------
        - path: str
            Paht of output `json` file
        """

        json.dump(self.get_course(), open(path, 'w'))

    def mkdir(self, root_dir='.'):
        """
        MKDIR makes course dir

        Parameters
        ----------
        - root_dir: str
            Path of root-directory
        """

        course = json.load(open('./course.json'))

        dir_name = 'Lynda - {}'.format(course['title'])
        base_dir = os.path.join(root_dir, dir_name)
        if os.path.exists(base_dir):
            shutil.rmtree(base_dir)
        os.mkdir(base_dir)

        for chapter in course['chapters']:
            os.mkdir(os.path.join(base_dir, chapter['title']))
            section_number = 1
            for section in chapter['sections']:
                open(\
                    os.path.join(\
                        base_dir,\
                        chapter['title'],\
                        '{}. {}.txt'.format(section_number, section['title'])\
                    ),\
                'w')\
                .write(section['transcript'])

                section_number += 1

        shutil.make_archive(base_dir, 'zip', root_dir, dir_name)
        shutil.rmtree(base_dir)

if __name__ == '__main__':
    main()

