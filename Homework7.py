#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 22:13:02 2023

@author: namansfolder
"""

#Name: Naman Pujani


# Problem 1.

def square_root_for(a, x0, max_iter = 10, tol=1e-14):
    """ (number, integer, number) -> float

    Return an estimate of the square root of a number using the Heron's method.
        
    >>> square_root_for(5, 5)
    Iteration | Estimate         | Relative Change
    -------------------------------------------------
    1         | 3.00000000000000 | 0.4000000000000000
    2         | 2.33333333333333 | 0.2222222222222222
    3         | 2.23809523809524 | 0.0408163265306123
    4         | 2.23606889564336 | 0.0009053870529653
    5         | 2.23606797749998 | 0.0000004106060359
    6         | 2.23606797749979 | 0.0000000000000842
    7         | 2.23606797749979 | 0.0000000000000000
    2.23606797749979
    """
    x = x0
    for i in range(1, max_iter + 1):
        y = (x + a / x) / 2
        delta = abs(y - x) / abs(x)
        print(f"{i:2d} | {y:.14f} | {delta:.16f}")
        if delta < tol:
            break
        x = y
    return y
           
# Don't change or delete the 5 lines of code below.
a = 5
max_iter = 100
tol = 1e-15
x_final = square_root_for(a, a, max_iter, tol)
print('Final estimate using square_root_for is {0}'.format(x_final))

# Problem 2.

def square_root_while(a, x0, tol=1e-14):
    """ (number, number, number) -> float

    Return an estimate of the square root of a number using the Heron's method.
        
    >>> square_root_while(5, 5)
    Iteration | Estimate         | Relative Change
    -------------------------------------------------
    1         | 3.00000000000000 | 0.4000000000000000
    2         | 2.33333333333333 | 0.2222222222222222
    3         | 2.23809523809524 | 0.0408163265306123
    4         | 2.23606889564336 | 0.0009053870529653
    5         | 2.23606797749998 | 0.0000004106060359
    6         | 2.23606797749979 | 0.0000000000000842
    7         | 2.23606797749979 | 0.0000000000000000
    2.23606797749979
    """
    x1 = 0.5 * (x0 + a / x0)
    delta_k = abs(x1 - x0) / abs(x0)
    i = 1
    while delta_k > tol:
        print(f"{i} | {round(x1, 14)} | {round(delta_k, 16)}")
        x0 = x1
        x1 = 0.5 * (x0 + a / x0)
        delta_k = abs(x1 - x0) / abs(x0)
        i += 1
    print(f"{i} | {round(x1, 14)} | {round(delta_k, 16)}")
    return round(x1, 14)


# Don't change or delete the 4 lines of code below.
a = 5
tol = 1e-15
x_final = square_root_while(a, a, tol)
print('Final estimate using square_root_while is {0}'.format(x_final))


if __name__ == "__main__":
    import doctest
    doctest.testmod()