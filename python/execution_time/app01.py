"""
APP01

powershell: Measure-Command {python .\app01.py}
unix: time python ./app01.py
"""
import time

def main():
    """
    MAIN
    """
    number_of_iterations = 4
    start_time = time.time()
    time_consuming_function(number_of_iterations)
    print(time.time() - start_time, 'sec')

def time_consuming_function(number_of_iterations):
    """
    TIME_CONSUMING_FUNCTION
    """
    for _ in range(10 ** number_of_iterations):
        for _ in range(10 ** number_of_iterations):
            pass

if __name__ == '__main__':
    main()
