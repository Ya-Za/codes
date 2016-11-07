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
    # transition function
    def d(q, a):
        return tt.get((q, a), None)
    
    # initial state
    q0 = 'q0'
    # final states
    F = ['q1']

    dfa = DFA(Q, S, d, q0, F)

    w = 'ababa'
    print(dfa.accept(w))
    dfa.print_state_sequences()

# DFA class
from termcolor import colored
class DFA(object):
    def __init__(self, Q, S, d, q0, F):
        self.Q = Q
        self.S = S
        self.d = d
        self.q0 = q0
        self.F = F

        self.w = ''             # word
        self.r = []             # sequence of states
        self.accepted = False   # accepted status

    def accept(self, w):
        self.w = w

        r = self.q0
        self.r.append(r)

        for a in w:
            r = self.d(r, a)
            self.r.append(r)

        if r in self.F:
            self.accepted = True
        else:
            self.accepted = False
        
        return self.accepted

    def print_state_sequences(self):
        print('w:', self.w)
        for i, a in enumerate(self.w):
            print('({}, {}) -> {}'.format(self.r[i], a, self.r[i + 1]))

        if self.accepted:
            print(colored('Accept.', 'green'))
        else:
            print(colored('Reject.', 'red'))

if __name__ == '__main__':
    main()