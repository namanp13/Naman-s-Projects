#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 26 20:20:12 2023

@author: namansfolder
"""




# ST114: Homework 6
# Name: Naman Pujani

# Instructions:
#   In this assignment, we will writing functions for estimating location and
#   scale parameters.
#
#   This Python file homework3.py has been provided for you. You will need to
#   edit it and then submit the file to gradescope. DO NOT RENAME THIS FILE!!

# Problem 1. Defining a function called my_median that returns the median of a list of 6 numbers
def my_median(x):
    """
    

    Parameters
    ----------
    x : A list of six numbers


    Returns the median of a given list of six numbers

    Here are two examples
    -------
   >>> x = [6, 5, 4, 3, 2, 1]
   >>> my_median(x)
   3.5
   >>> x = [5, 9, 10, 14, 17, 19]
   >>> my_median(x)
   12.0

    """
    sorted_x = sorted(x)
    middle = len(sorted_x) // 2
    if len(sorted_x) % 2 == 0:
        return (sorted_x[middle - 1] + sorted_x[middle]) / 2
    else:
        return sorted_x[middle]
x = [6, 5, 4, 3, 2, 1]
print(my_median(x))

# Problem 2. Defining a function called L statistic that takes in a list of numbers and returns the L-statistic based on the list and its weights
def L_statistic(x,w):
    """
    

    Parameters
    ----------
    x : List of 6 numbers
        
    w : List of numbers that are a weighted list
        

    Returns the L Statistic value
    
    Here is an example
    -------
    >>> x = [2, 3, 4, 5, 6, 7]
    >>> w = [1, 2, 5, 1, 2, 1]
    >>> L_statistic(x,w)
    52
    

    """
    sum = 0
    for (a,b) in zip(x,w):
        sum += a*b
    return sum
x = [2, 3, 4, 5, 6, 7]
w = [1, 2, 5, 1, 2, 1]
L_statistic(x,w)
print(L_statistic(x,w))
# Problem 3. Defining a function called trimmed_mean that returns the trimmed mean of a list of numbers
def trimmed_mean(x):
    """
    

    Parameters
    ----------
    x : List of numbers
        

    Returns the trimmed mean of a list
    
    Here is an example
    -------
    >>> x = [2, 3, 4, 5, 6, 7]
    >>> trimmed_mean(x)
    4.5
    

    """
    return L_statistic(x[1:5],[1]*4) / 4
x = [2, 3, 4, 5, 6, 7]
print(trimmed_mean(x))

# Problem 4. Defining a function called MAD that returns the MAD of a list of numbers
def MAD(x):
    """
    

    Parameters
    ----------
    x : List of numbers
        

    Returns the MAD of the list of values
    Here is an example
    -------
    >>> x = [1, 2, 3, 4, 5, 6]
    >>> MAD(x)
    1.5

    """
    l = len(x)
    median = my_median(x)
    deviation = [abs(x[i] - median) for i in range(l)]
    mad = my_median(deviation)
    return mad
x = [2, 3, 4, 5, 6, 7]
print(MAD(x))

# Problem 5. Defining a function location_and_scale that returns a formatted string with the median and MAD to a certain decimal place
def location_and_scale(x):
    """
    

    Parameters
    ----------
    x : List of numbers
        

    Returns the median and MAD to a specific decimal place
    Here is an example
    -------
    >>> x = [1, 2, 3, 4, 5, 6]
    >>> location_and_scale(x)
    'The median is 3.50000 and the MAD is 1.5000.'

    """
    formatted_string = "The median is {:.5f} and the MAD is {:.4f}.".format(my_median(x), MAD(x))
    return formatted_string
x = [1, 2, 3, 4, 5, 6]
print(location_and_scale(x))
    
if __name__ == "__main__":
    import doctest
    print(doctest.testmod())