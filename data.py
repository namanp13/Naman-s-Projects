#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr  3 22:10:56 2023

@author: namansfolder
"""

#1. Writing a class Data with a method init that takes two lists of numbers as parameters and stores them as x and y
import matplotlib.pyplot as plt

class Data:
    def init(self, x, y):
        self.x = x
        self.y = y

#2. Writing another data method that outputs the number of observations in the data, meaning the length
    def num_obs(self):
        """ (Data) -> int

    Return the number of observations in the data set.

    >>> data = Data([1, 2], [3, 4])
    >>> data.num_obs()
    2
    """
        return len(self.x)

#3. Writing a string method that returns a specific format
    def __str__(self):
        """ (Data) -> str
    Return a string representation of this Data in this format:
    x	        y
    18.000          120.000
    20.000          110.000
    22.000          120.000
    25.000          135.000
    26.000          140.000
    29.000          115.000
    30.000          150.000
    33.000          165.000
    33.000          160.000
    35.000          180.000
    """
    string_rep = "x\ty\n"
    for i in range(len(self.x)):
            string_rep += "{:.3f}\t{:.3f}\n".format(self.x[i], self.y[i])
        return string_rep
    
if __name__ == "__main__":
    import doctest
    print(doctest.testmod(verbose = True))
    
#Homework 11 

#1. Writing another data method that returns the sample mean of attributes of x and y, as a tuple of numbers
def compute_sample_means(self):
    mean_x = sum(self.x) / len(self.x)
    mean_y = sum(self.y) / len(self.y)
    return (mean_x, mean_y)

#2. Wriitng a method that returns the slope and intercept of the simple linear regression fit of the data
def compute_least_squares_fit(self):
        n = len(self.x)
        sum_x = sum(self.x)
        sum_y = sum(self.y)
        sum_xy = sum([xi * yi for xi, yi in zip(self.x, self.y)])
        sum_xx = sum([xi**2 for xi in self.x])
        slope = (n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x**2)
        intercept = (sum_y - slope * sum_x) / n
        return (intercept, slope)

#3. Writing a method that returns the sum of squares total for y
def compute_SST(self):
        y_mean = sum(self.y) / len(self.y)
        SST = sum((yi - y_mean) ** 2 for yi in self.y)
        return SST

#4. Writing two plot methods that return None
def hist_x(self):
        plt.hist(self.x)
        plt.xlabel('x')
        plt.ylabel('y')
        plt.show()
        return None
    
    def hist_y(self):
        plt.hist(self.y)
        plt.xlabel('x')
        plt.ylabel('y')
        plt.show()
        return None





