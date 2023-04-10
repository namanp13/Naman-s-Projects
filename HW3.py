#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 30 17:12:54 2023

@author: namansfolder
"""

# Homework 3

from statistics import median

# 1. Calculating the mean of a list
L = [1.0, 2.0, 5.0, 4.0, 3.0]

mean_L = sum(L) / len(L)
print(mean_L)

# 2. Calculate the median where n is odd
n = (len(L) + 1) / 2
median_L = L[2]
print(median_L)

# 3. Calculating the sample standard deviation using a for loop
ss = 0
for x in L:
    ss += (x - mean_L)**2
samplestd_L = ss / (len(L) - 1)
print(samplestd_L)

# 4. Calculating sample standard deviation using list comprehension
ss_mean_L = [(num-mean_L)**2 for num in L]
sample_var = sum(ss_mean_L) / (len(ss_mean_L) -1)
print(sample_var)

#5. Calculating the median absolute deviation where n is odd using a for loop
med_value = median(L)
for numbers in L:
    median_abs_dev = median([abs(numbers - med_value)])
    print(median_abs_dev)

#6. Calculating the median absolute deviation when n is odd using list comprehension
med_value2 = median(L)
median_abs_dev2 = median([abs((L[0] + L[1] + L[2] + L[3] + L[4]) - med_value2)])
print(median_abs_dev2)

#7. Using f string formatting to print out each statement
print(f"The mean of the list is {mean_L}.")
print(f"The median of the list is {median_L}.")
print(f"The sample standard deviation using a for loop is {samplestd_L}.")
print(f"The sample standard deviation using list comprehension is {sample_var}.")
print(f"The median absolute deviation using a for loop is {median_abs_dev}.")
print(f"The median absolute deviation using list comprehension is {median_abs_dev2}")