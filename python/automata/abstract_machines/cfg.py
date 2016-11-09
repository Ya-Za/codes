# Context free grammar
def main():
    N = {'S', 'A', 'B'}
    T = {'a', 'b'}
    P = {
        'S': [['A', 'B']],
        'A': [['a']],
        'B': [['b']]
    }
    S = 'S'

    cfg = CFG(N, T, P, S)
    w = 'ab'
    print(cfg.pda.accept(w))
    cfg.pda.print_computation()

from pda import PDA
class CFG(object):
    def __init__(self, N, T, P, S):
        self.N = N
        self.T = T
        self.P = P
        self.S = S

        self.pda = self.get_pda()

    def get_pda(self):
        tt = {}
        # expand
        for A, alpha in self.P.items():
            value = []
            for item in alpha:
                value.append(('1', item))
            tt[('1', '', A)] = value

        # match
        for a in self.T:
            tt[('1', a, a)] = [('1', [])]

        return PDA({'1'}, self.T, (self.N | self.T), tt, '1', self.S, None)

if __name__ == '__main__':
    main()