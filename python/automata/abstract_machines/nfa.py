def main():
    # states
    Q = {'q0', 'q1'}
    # alphabet
    S = {'a', 'b'}
    # state transition table
    tt = {
        ('q0', 'a'): {'q1', 'q2'},
        ('q2', 'b'): {'q3'}
    }
    
    # initial state
    q0 = 'q0'
    # final states
    F = {'q1', 'q3'}

    nfa = NFA(Q, S, tt, q0, F)

    w = 'ab'
    print(nfa.accept2(w))
    #nfa.print_state_sequences()
    nfa.print_computation2()

# NFA class
from termcolor import colored
class NFA(object):
    def __init__(self, Q, S, tt, q0, F):
        self.Q = Q
        self.S = S
        self.tt = tt
        self.q0 = q0
        self.F = F

        self.w = ''             # word
        self.r = []             # sequence of states
        self.accepted = False   # accepted status

    def D(self, P, a):
        Q = set()
        for p in P:
            Q = Q | self.tt.get((p, a), set())
        
        if len(Q) == 0:
            return None
        return Q

    def d(self, p, a):
        return self.tt.get((p, a), None)
    
    def accept(self, w):
        self.w = w

        r = {self.q0}
        self.r.append(r)

        i = 0
        while(r is not None and i < len(w)):
            r = self.D(r, w[i])
            self.r.append(r)
            i += 1

        if r is not None and len(r & self.F) > 0:
            self.accepted = True
        else:
            self.accepted = False
        
        return self.accepted

    def accept2(self, w):
        self.w = w
        self.r = []
        self.accepted = False
        
        self.rec_accept(w, self.q0)
        self.r.reverse()
        
        return self.accepted
    
    def rec_accept(self, w, q):
        if w == '' and q in self.F:
            self.r.append(q)
            self.accepted = True
            return
        
        P = self.d(q, w[0])
        if P is None:
            return
        for p in P:
            self.rec_accept(w[1:], p)
            if self.accepted:
                self.r.append(q)
                return


    
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
            print('({:<{m}}, {:>{n}}) |--'.format(str(self.r[i]), self.w[i:], m = m, n = n))
        print('({:<{m}}, {:>{n}}) |--'.format(str(self.r[-1]), '', m = m, n = n))

        if self.accepted:
            print(colored('Accept.', 'green'))
        else:
            print(colored('Reject.', 'red'))

    def print_computation2(self):
        if self.accepted:
            print(colored('Accept.', 'green'))
            m = max(len(str(x)) for x in self.r)
            n = len(self.w)
            for i in range(len(self.r) - 1):
                print('({:<{m}}, {:>{n}}) |--'.format(str(self.r[i]), self.w[i:], m = m, n = n))
            print('({:<{m}}, {:>{n}}) |--'.format(str(self.r[-1]), '', m = m, n = n))
        else:
            print(colored('Reject.', 'red'))

if __name__ == '__main__':
    main()