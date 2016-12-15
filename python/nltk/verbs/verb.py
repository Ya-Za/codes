
def main():
    '''
    Test of 'Verb' class
    '''

    print(Verb.get_verb('book', \
        subject=3, \
        tense=-1, \
        continuous=True, \
        perfect=True, \
        negative=True, \
        interrogative=True, \
        passive=True))


class Verb(object):
    '''
    All variation of verbs in english grammar
    '''

    pron = ('I ', 'you ', 'he/she/it ', 'we ', 'you ', 'they ')

    def __init__(self):
        pass

    @staticmethod
    def get_verb(verb, \
    subject=1, \
    tense=0, \
    continuous=False, \
    perfect=False, \
    negative=False, \
    interrogative=False, \
    passive=True):
        '''
        Get verb based on code
        subject = [1, 2, 3, 4, 5, 6] = [
            'first person singular (I)',
            'second person singulart (you),
            'third person singular (he/she/it)',
            'first person plural (we)',
            'second person plural (you)',
            'third person plural (they)'
        ]
        tense = [-1, 0, 1] = ['past', 'present', 'future']
        continuous = [False, True]
        perfect = [False, True]
        negative = [False, True]
        interrogative = [False, True]
        passive = [False, True]
        '''
        will = ''
        if tense == 1:
            will = 'will '

        have = ''
        if perfect:
            if tense == -1:
                have = 'had '
            elif tense == 0:
                if subject == 3:
                    have = 'has '
                else:
                    have = 'have '
            else:
                have = 'have '

        tobe = ''
        if continuous:
            if perfect:
                tobe = 'been '
            else:
                if tense == -1:
                    if subject == 1 or 3:
                        tobe = 'was '
                    else:
                        tobe = 'were '
                elif tense == 0:
                    if subject == 1:
                        tobe = 'am '
                    elif subject == 3:
                        tobe = 'is '
                    else:
                        tobe = 'are '
                else:
                    tobe = 'be '

        subject = Verb.pron[subject - 1]
        aux = ''
        if passive:
            if tobe != '':
                aux = 'being '
            elif have != '':
                aux = 'been '
            else:
                if tense == -1:
                    if subject == 1 or subject == 3:
                        aux = 'was '
                    else:
                        aux = 'were'
                elif tense == 0:
                    if subject == 1:
                        aux = 'am'
                    elif subject == 3:
                        aux = 'is'
                    else:
                        aux = 'are'
                else:
                    aux = 'be '

        if negative:
            if will != '':
                will += 'not '
            elif have != '':
                have += 'not '
            elif tobe != '':
                tobe += 'not '
            elif aux != '':
                aux += 'not'
            else:
                if tense == -1:
                    ed_ = ''
                    aux = 'did not '
                elif tense == 0:
                    es_ = ''
                    if subject == 3:
                        aux = 'does not '
                    else:
                        aux = 'do not '

        if interrogative:
            if will != '':
                will += subject
            elif have != '':
                have += subject
            elif tobe != '':
                tobe += subject
            elif aux != '':
                aux += subject
            else:
                if tense == -1:
                    ed_ = ''
                    aux = 'did ' + subject
                elif tense == 0:
                    es_ = ''
                    if subject == 3:
                        aux = 'does ' + subject
                    else:
                        aux = 'do ' + subject

        es_ = ''
        if will == '' and have == '' and tobe == '' and aux == '' and subject == 3:
            es_ = 's '

        ed_ = ''
        if passive or \
        (perfect and not continuous) or \
        (tense == -1 and not continuous and not negative and not interrogative):
            ed_ = 'ed '

        ing_ = ''
        if not passive and continuous:
            ing_ = 'ing'

        verb = will + have + tobe + aux + verb + es_ + ed_ + ing_

        if interrogative:
            return verb
        else:
            return subject + verb


if __name__ == '__main__':
    main()
