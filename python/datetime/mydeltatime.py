from mydatetime import MyDateTime

def main():
    dt = MyDeltaTime(year=1, month=2, hour=1, minute=10)
    print(dt)

class MyDeltaTime(object):
    __attributes = [
        'year',
        'month',
        'day',
        'hour',
        'minute',
        'second',
        'millisecond'
    ]

    def __init__(self, **kwargs):
        self.clear()

        for a in MyDeltaTime.__attributes:
            if a in kwargs:
                setattr(self, a, kwargs[a])

    def clear(self):
        for a in MyDeltaTime.__attributes:
            setattr(self, a, 0)

    def total_ms_except_year_and_month(self):
        n = 0

        # days
        n += MyDateTime.d_to_ms(self.day)
        
        # hours
        n += MyDateTime.h_to_ms(self.hour)
        
        # minutes
        n += MyDateTime.m_to_ms(self.minute)
        
        # seconds
        n += MyDateTime.s_to_ms(self.second)
        
        # milliseconds
        n += self.millisecond
        
        return n

    def __str__(self):
        return '{:0>4}-{:0>2}-{:0>2} {:0>2}:{:0>2}:{:0>2}:{:0>3}'.format(
            self.year, 
            self.month, 
            self.day, 
            self.hour, 
            self.minute, 
            self.second, 
            self.millisecond
        )

if __name__ == '__main__':
    main()