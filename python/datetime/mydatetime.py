from mydeltatime import *

def main():
    # dt = MyDateTime()
    # dt.year = 0
    # dt.month = 11
    # dt.day = 30
    # dt.hour = 23
    # dt.minute = 59
    # dt.second = 59
    # dt.millisecond = 999
    # print(dt)
    # dt.add_ms(1)
    # print(dt)

    # dt = MyDateTime()
    # dt.year = 2015
    # dt.month = 0
    # dt.day = 0
    # dt.hour = 0
    # dt.minute = 0
    # dt.second = 0
    # dt.millisecond = 0
    # print(dt)
    # delta = MyDeltaTime(year=1)
    # dt.add_deltatime(delta)
    # print(dt)

    # dt = MyDateTime()
    # dt.year = 2015
    # dt.month = 0
    # dt.day = 0
    # dt.hour = 0
    # dt.minute = 0
    # dt.second = 0
    # dt.millisecond = 0
    # print(dt)
    # delta = MyDeltaTime(year=1)
    # dt.sub_deltatime(delta)
    # print(dt)

    dt = MyDateTime()
    dt.year = 2015
    dt.month = 0
    dt.day = 0
    dt.hour = 1
    dt.minute = 30
    dt.second = 0
    dt.millisecond = 0
    dt.timezone = (1, 30)
    print(dt)
    print(dt.local())

class MyDateTime:
    ms_per_leap_year = None
    ms_per_common_year = None

    common_monthes = [
            {'name': 'January', 'days': 31},
            {'name': 'February', 'days': 28},
            {'name': 'March', 'days': 31},
            {'name': 'April', 'days': 30},
            {'name': 'May', 'days': 31},
            {'name': 'June', 'days': 30},
            {'name': 'July', 'days': 31},
            {'name': 'August', 'days': 31},
            {'name': 'September', 'days': 30},
            {'name': 'October', 'days': 31},
            {'name': 'November', 'days': 30},
            {'name': 'December', 'days': 31}
    ]
    leap_monthes = [
            {'name': 'January', 'days': 31},
            {'name': 'February', 'days': 29},
            {'name': 'March', 'days': 31},
            {'name': 'April', 'days': 30},
            {'name': 'May', 'days': 31},
            {'name': 'June', 'days': 30},
            {'name': 'July', 'days': 31},
            {'name': 'August', 'days': 31},
            {'name': 'September', 'days': 30},
            {'name': 'October', 'days': 31},
            {'name': 'November', 'days': 30},
            {'name': 'December', 'days': 31}
    ]
    
    def __init__(self):
        self.clear()
    
    def clear(self):
        self.year = 0
        self.month = 0
        self.day = 0
        self.hour = 0
        self.minute = 0
        self.second = 0
        self.millisecond = 0

        self.timezone = (0, 0)
    
    def datetime_to_ms(self):
        n = 0
        
        # year
        for y in range(self.year):
            if MyDateTime.is_leap_year(y):
                n += MyDateTime.ms_per_leap_year
            else:
                n += MyDateTime.ms_per_common_year
                
        # monthes
        if MyDateTime.is_leap_year(self.year):
            monthes = MyDateTime.leap_monthes
        else:
            monthes = MyDateTime.common_monthes
        
        for m in range(self.month):
            n +=  MyDateTime.d_to_ms(monthes[m]['days'])
        
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
    
    def add_ms(self, n):
        n += self.datetime_to_ms()
        self.clear()
        
        # years
        while True:
            if MyDateTime.is_leap_year(self.year):
                ms_per_year = MyDateTime.ms_per_leap_year
            else:
                ms_per_year = MyDateTime.ms_per_common_year
            
            if n >= ms_per_year:
                n -= ms_per_year
                self.year += 1
            else:
                break

        # monthes
        if MyDateTime.is_leap_year(self.year):
            monthes = MyDateTime.leap_monthes
        else:
            monthes = MyDateTime.common_monthes
        
        for m in monthes:
            ms_per_month = MyDateTime.d_to_ms(m['days'])
            if n >= ms_per_month:
                n -= ms_per_month
                self.month += 1
            else:
                break
                
        # days
        (self.day, n) = divmod(n, MyDateTime.d_to_ms(1))
        
        # hours
        (self.hour, n) = divmod(n, MyDateTime.h_to_ms(1))
        
        # minutes
        (self.minute, n) = divmod(n, MyDateTime.m_to_ms(1))
        
        # seconds
        (self.second, n) = divmod(n, MyDateTime.s_to_ms(1))
        
        # milliseconds
        self.millisecond = n
    
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
    
    def local(self):
        import copy
        clone = copy.deepcopy(self)
        clone.add_deltatime(MyDeltaTime(hour=clone.timezone[0], minute=clone.timezone[1]))
        return str(clone)

    def add_deltatime(self, other):
        if type(other) is not MyDeltaTime:
            raise TypeError()
        
        # update
        # --millisecond up to day
        self.add_ms(other.total_ms_except_year_and_month())
        # --month
        (y, self.month) = divmod(self.month + other.month, 12)
        # --year
        self.year += other.year + y
    
    def sub_deltatime(self, other):
        if type(other) is not MyDeltaTime:
            raise TypeError()
        
        # update
        # --millisecond up to day
        self.add_ms(-other.total_ms_except_year_and_month())
        # --month, year
        m1 = self.year * 12 + self.month
        m2 = other.year * 12 + other.month

        (self.year, self.month) = divmod(m1 - m2, 12)

    def __sub__(self, other):
        return self.datetime_to_ms() - other.datetime_to_ms()
    
    def is_leap_year(year):
        if year % 400 == 0:
            return True
        if year % 100 == 0:
            return False
        if year % 4 == 0:
            return True
        return False
    
    def s_to_ms(s):
        return s * 1000
    def m_to_ms(m):
        return m * MyDateTime.s_to_ms(60)
    def h_to_ms(h):
        return h * MyDateTime.m_to_ms(60)
    def d_to_ms(d):
        return d * MyDateTime.h_to_ms(24)

MyDateTime.ms_per_leap_year = MyDateTime.d_to_ms(366)
MyDateTime.ms_per_common_year = MyDateTime.d_to_ms(365)

if __name__ == '__main__':
    main()