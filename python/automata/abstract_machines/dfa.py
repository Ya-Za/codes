def main():
    # states
    Q = ['q0', 'q1']
    # alphabet
    S = ['a', 'b']
    # state transition table
    tt = {
        ('q0', 'a'): 'q1',
        ('q1', 'b'): 'q0'
    }
    
    # initial state
    q0 = 'q0'
    # final states
    F = ['q1']

    dfa = DFA(Q, S, tt, q0, F)

    w = 'ababa'
    print(dfa.accept(w))
    #dfa.print_state_sequences()
    dfa.print_computation()

# DFA class
from termcolor import colored
class DFA(object):
    def __init__(self, Q, S, tt, q0, F):
        self.Q = Q
        self.S = S
        self.tt = tt
        self.q0 = q0
        self.F = F

        self.w = ''             # word
        self.r = []             # sequence of states
        self.accepted = False   # accepted status

    def d(self, p, a):
        return self.tt.get((p, a), None)
    
    def accept(self, w):
        self.w = w

        r = self.q0
        self.r.append(r)

        i = 0
        while(r is not None and i < len(w)):
            r = self.d(r, w[i])
            self.r.append(r)
            i += 1

        # for a in w:
        #     r = self.d(r, a)
        #     self.r.append(r)

        if r in self.F:
            self.accepted = True
        else:
            self.accepted = False
        
        return self.accepted

    def print_state_sequences(self):
        print('w:', self.w)
        for i in range(len(self.r) - 1):
            print('({}, {}) -> {}'.format(self.r[i], self.w[i], self.r[i + 1]))

        if self.accepted:
            print(colored('Accept.', 'green'))
        else:
            print(colored('Reject.', 'red'))

    def print_computation(self):
        m = max(len(str(x)) for x in self.r)
        n = len(self.w)
        for i in range(len(self.r) - 1):
            print('({:<{m}}, {:>{n}}) |--'.format(self.r[i], self.w[i:], m = m, n = n))
        print('({:<{m}}, {:>{n}}) |--'.format(str(self.r[-1]), '', m = m, n = n))

        if self.accepted:
            print(colored('Accept.', 'green'))
        else:
            print(colored('Reject.', 'red'))


if __name__ == '__main__':
    main()