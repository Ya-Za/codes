"""
ldoce : Longman Dictionary of Contemporary English
"""
from pprint import pprint
import matplotlib.pyplot as plt
from matplotlib_venn import venn3
import numpy as np
import nltk

def main():
    """
    Test of ldoce class.
    """
    ldoce = LDOCE()

    # ldoce.index_plot()
    # ldoce.length_plot()
    ldoce.pos_plot()

class LDOCE(object):
    """
    LDOCE : Longman Dictionary of Contemporary English
    """

    def __init__(self):
        self.defining = {x.strip() for x in open('./data/defining.txt').readlines()}
        self.communication = {x.strip() for x in open('./data/communication.txt').readlines()}
        self.academic = {x.strip() for x in open('./data/academic.txt').readlines()}
        self.all = self.defining | self.communication | self.academic

    def venn(self):
        """
        Plot venn diagram
        """
        venn3([self.defining, self.communication, self.academic], \
            set_labels=('Defining', 'Communication', 'Academic'))
        plt.show()

    def index_plot(self):
        """
        Bar chart based on number of each index
        """
        x_values = LDOCE.get_alphabet()
        y_values = [0] * len(x_values)

        code_a = ord('A')
        for word in self.all:
            y_values[ord(word[0].upper()) - code_a] += 1

        plt.bar(range(len(x_values)), y_values, align='center')
        plt.xticks(range(len(x_values)), x_values)
        plt.show()

    def length_plot(self):
        """
        Box plot of length of words
        """
        data = [len(x) for x in self.all]

        dic = {}
        for word in self.all:
            length = len(word)
            if length not in dic:
                dic[length] = 1
            else:
                dic[length] += 1

        _, axes = plt.subplots(nrows=1, ncols=2)

        # bar plot
        axes[0].bar(range(len(dic)), dic.values(), align='center')
        axes[0].set_xticks(range(len(dic)))
        axes[0].set_xticklabels(dic.keys())
        axes[0].set_title('{} +- {}'.format(round(np.mean(data), 2), round(np.std(data), 2)))

        # box plot
        axes[1].boxplot(data, vert=False)
        axes[1].set_yticks([])

        plt.show()
    
    def pos_plot(self):
        """
        Bar plot of part-of-speech(pos)
        """
        data = {}
        for word in self.all:
            pos = nltk.pos_tag([word])[0][1]
            if pos not in data:
                data[pos] = 1
            else:
                data[pos] += 1

        pprint(data)

        plt.bar(range(len(data)), data.values(), align='center')
        plt.xticks(range(len(data)), data.keys())
        plt.show()

    @staticmethod
    def get_alphabet():
        """
        Get english alphabet: ['A', 'B', ..., 'Z']
        """
        letter = 'A'
        alphabet = []
        while True:
            alphabet.append(letter)
            if letter == 'Z':
                break
            letter = chr(ord(letter) + 1)

        return alphabet

if __name__ == '__main__':
    main()
