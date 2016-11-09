def main():
    # states
    Q = {'A', 'B', 'C', 'HALT'}
    # tape alphabet
    G = {'0', '1'}
    # blank symbol
    b = '0'
    # alphabet
    S = {'1'}
    
    # state transition table
    tt = {
        ('A', '0'): ('B', '1', 'R'),
        ('B', '0'): ('A', '1', 'L'),
        ('C', '0'): ('B', '1', 'L'),
        ('A', '1'): ('C', '1', 'L'),
        ('B', '1'): ('B', '1', 'R'),
        ('C', '1'): ('HALT', '1', 'R')
    }
    
    # initial state
    q0 = 'A'
    # final states
    F = {'HALT'}

    tm = TM(Q, G, b, S, tt, q0, F)

    w = '1'
    print(tm.accept(w))
    tm.print_computation()

# TM class
from termcolor import colored
from collections import deque
class TM(object):
    def __init__(self, Q, G, b, S, tt, q0, F):
        self.Q = Q
        self.G = G
        self.b = b
        self.S = S
        self.tt = tt
        self.q0 = q0
        self.F = F

        self.w = ''             # word
        self.computations = []  # sequence of states
        self.accepted = False   # accepted status

    def d(self, p, a):
        return self.tt.get((p, a), (None, None, None))
    
    def accept(self, w):
        self.w = w

        tape = deque(list(w))
        p = self.q0
        head = 0
        while(True):
            self.computations.append((p, str(head), ''.join(tape)))

            a = tape[head]
            (p, a, shift) = self.d(p, a)
            
            if p is None or p == 'HALT':
                break
            
            tape[head] = a
            if shift == 'R':
                head += 1
                if head >= len(tape):
                    tape.append(self.b)
            if shift == 'L':
                head -= 1
                if head < 0:
                    head = 0
                    tape.appendleft(self.b)


        self.computations.append((p, str(head), ''.join(tape)))

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
            print('({:<{m}}, {:>{n}}, {:<{o}}) |--'.format(id_[0], id_[1], id_[2], m = m, n = n, o = o))

        if self.accepted:
            print(colored('Accept.', 'green'))
        else:
            print(colored('Reject.', 'red'))

if __name__ == '__main__':
    main()