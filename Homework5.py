#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 14:15:47 2023

@author: namansfolder
"""

# ST114: Homework 5
# Name: Naman Pujani

# Instructions:
# In this assignment, we will practice using sorting and list comprehensions.
#
# A Python file homework5.py has been provided for you. 
# You will need to edit it and then submit the file to 
# gradescope.

## Feel free to use the following global variable alphabet
alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']


# Problem 1. 
def cipher(shift):
    alphabet2 = {'a' : 'a', 'b' : 'b', 'c' : 'c', 'd' : 'd', 'e' : 'e', 'f' : 'f', 'g' : 'g', 'h' : 'h', 'i' : 'i', 'j' : 'j', 'k' : 'k', 'l' : 'l', 'm' : 'm', 'n' : 'n', 'o' : 'o', 'p' : 'p', 'q' : 'q', 'r' : 'r', 's' : 's', 't' : 't', 'u' : 'u', 'v' : 'v', 'w' : 'w', 'x' : 'x', 'y' : 'y', 'z' : 'z'}
    alphabet1 = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    for i in range (0,26):
        alphabet2[alphabet1[i]]=alphabet1[(i + shift)%26]
        return(alphabet2)
try1 = cipher(-3)
print(try1)
    
# Problem 2
def decode(text,alphabet2):
    decoded = ""
    for i in text:
        decoded+=alphabet2[i]
    return(decoded)
    print(decoded)
try2 = cipher(-3)
a = decode("abcd", try2)
print(a)


# Problem 3
def extra(text):
    text2 = ""
    for i in text:
        if(i.isalpha()):
            text2+=i
    return(text2)
extra("boo!\n")


# Problem 4
string = 'helloworld'
letters = {}
for i in string:
    if i.isalpha():
        i = i.lower()
        letters[i] = letters.get(i, 0) + 1
print(letters)
 
# Problem 5
print(f"I decoded this string with a shift paramater of 5")




