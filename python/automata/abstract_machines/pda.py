def main():
    '''
    # states
    Q = {'p', 'q', 'r'}
    # alphabet
    S = {'0', '1'}
    # stack alphabet
    G = {'A', 'Z'}
    # state transition table

    tt = {
        ('p', '0', 'Z'): [('p', ['A', 'Z'])],
        ('p', '0', 'A'): [('p', ['A', 'A'])],
        ('p',  '', 'Z'): [('q', ['Z'])],
        ('p',  '', 'A'): [('q', ['A'])],
        ('q', '1', 'A'): [('q', [])],
        ('q',  '', 'Z'): [('r', ['Z'])]
    }

    # initial state
    q0 = 'p'
    # initial stack symbol
    Z = 'Z'
    # final states
    F = {'r'}
    '''

    # states
    Q = {'q0', 'q1', 'q2', 'q3'}
    # alphabet
    S = {'a', 'b'}
    # stack alphabet
    G = {'0', '1'}
    # state transition table
    tt = {
        ('q0', 'a', '0'): [('q1', ['1', '0']), ('q3', [])],
        ('q0', '', '0'): [('q3', [])],
        ('q1',  'a', '1'): [('q1', ['1', '1'])],
        ('q1',  'b', '1'): [('q2', [])],
        ('q2', 'b', '1'): [('q2', [])],
        ('q2',  '', '0'): [('q3', [])]
    }
    # initial state
    q0 = 'q0'
    # initial stack symbol
    Z = '0'
    # final states
    F = {'q3'}

    pda = PDA(Q, S, G, tt, q0, Z, F)

    w = 'aaabbb'
    print(pda.accept(w))
    pda.print_computation()

# PDA class
from termcolor import colored
class PDA(object):
    def __init__(self, Q, S, G, tt, q0, Z, F):
        self.Q = Q
        self.S = S
        self.G = G
        self.tt = tt
        self.q0 = q0
        self.Z = Z
        self.F = F

        self.computations = []  # sequence of states
        self.accepted = False   # accepted status

    def d(self, p, a, A):
        return self.tt.get((p, a, A), None)

    def accept(self, w):
        self.computations = []
        self.accepted = False

        self.rec_accept(self.q0, w, [self.Z])
        self.computations.reverse()

        return self.accepted

    def rec_accept(self, p, w, stack):
        if w == '':
            if (self.F is None and len(stack) == 0) or (self.F is not None and p in self.F):
                self.accepted = True
                self.computations.append((p, w, ''.join(reversed(stack))))
                return

        if w != '':
            # match
            match_stack = stack.copy()
            res = self.d(p, w[0], match_stack.pop())
            if res is not None:
                for item in res:
                    (q, alpha) = item
                    alpha.reverse()
                    self.rec_accept(q, w[1:], match_stack + alpha)
                    if self.accepted:
                        self.computations.append((p, w, ''.join(reversed(stack))))
                        return

        # expand
        expand_stack = stack.copy()
        res = self.d(p, '', expand_stack.pop())
        if res is not None:
            for item in res:
                (q, alpha) = item
                alpha.reverse()
                self.rec_accept(q, w, expand_stack + alpha)
                if self.accepted:
                    self.computations.append((p, w, ''.join(reversed(stack))))
                    return


    def print_computation(self):
        if self.accepted == False:
            print(colored('Reject.', 'red'))
            return
        
        print(colored('Accept.', 'green'))
        m = max(len(str(x[0])) for x in self.computations)
        n = max(len(str(x[1])) for x in self.computations)
        o = max(len(str(x[2])) for x in self.computations)

        for id_ in self.computations:
            print('({:<{m}}, {:>{n}}, {:>{o}}) |--'.format(str(id_[0]), str(id_[1]), str(id_[2]), m = m, n = n, o = o))
            
        

if __name__ == '__main__':
    main()

"""
    def accept(self, w):
        stack = [self.Z]
        p = self.q0
        i = 0
        while(i < len(w)):
            self.computations.append((p, w[i:], ''.join(reversed(stack))))

            a = w[i]
            A = stack.pop()
            (p, alpha) = self.d(p, w[i], A)
            
            if p is None:
                break
            
            stack.extend(reversed(alpha))
            i += 1

        self.computations.append((p, w[i:], ''.join(reversed(stack))))

        if p in self.F:
            self.accepted = True
        else:
            self.accepted = False
        
        return self.accepted

    def print_computation(self):
        m = max(len(str(x[0])) for x in self.computations)
        n = max(len(str(x[1])) for x in self.computations)
        o = max(len(str(x[2])) for x in self.computations)

        for id_ in self.computations:
            print('({:<{m}}, {:>{n}}, {:>{o}}) |--'.format(str(id_[0]), str(id_[1]), str(id_[2]), m = m, n = n, o = o))

        if self.accepted:
            print(colored('Accept.', 'green'))
        else:
            print(colored('Reject.', 'red'))

"""