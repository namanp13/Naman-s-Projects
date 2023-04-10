#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb  6 17:02:08 2023

@author: namansfolder
"""

x = [2.5, 3.7, 1.2, 5.0]
mu = 1.6
cl = 95

#1. Stating that the 90 and 99 confidence levels are not supported
print(cl)
print(f"The 90 and 99 confidence level are not supported")

#2. Calculating the t-statistic using the give formula
sample_mean = (sum(x)/len(x))
print(sample_mean)

diff1 = ((1 / (len(x) - 1)) * ((x[0] - sample_mean)**2))
diff2 = ((1 / (len(x) - 1)) * ((x[1] - sample_mean)**2))
diff3 = ((1 / (len(x) - 1)) * ((x[2] - sample_mean)**2))
diff4 = ((1 / (len(x) - 1)) * ((x[3] - sample_mean)**2))

sample_variance = (diff1 + diff2 + diff3 + diff4) / 3
print(sample_variance)

sample_std_dev = sample_variance**(0.5)
print(sample_std_dev)

std_error = sample_std_dev / (4**(0.5))
print(std_error)

t_statistic = (sample_mean - mu) / std_error
print(t_statistic)

#3. Using if else logic to state whether or not the t-statistic is significant at the 99% confidence level
if (abs(t_statistic) > 5.84):
    print(f"There is a statistically significant difference at the 99% confidence level")
else:
    print("There is not a statistically signifcant difference at the 99% confidence level")

#4.Using if else logic to state whether or not the t-statistic is significant at the 95% confidence level
if (abs(t_statistic) > 3.18):
    print(f"There is a statistically significant difference at the 95% confidence level")
else:
    print("There is not a statistically signifcant difference at the 95% confidence level")

#5.Using if else logic to state whether or not the t-statistic is significant at the 90% confidence level
if (abs(t_statistic) > 2.35):
    print(f"There is a statistically significant difference at the 90% confidence level")
else:
    print("There is not a statistically signifcant difference at the 90% confidence level")