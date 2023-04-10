#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 27 17:06:58 2023

@author: namansfolder
"""

#1.Writing a Point class that takes two numbers as parameters
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.coords = (x , y)
p1 = Point(1 , 1)
p1.x
p1.y
p1.coords
p2 = Point(2,3)
p2.coords

#2. Writing another class whose constructor takes two Points as parameters
class LineSegment:
    def __init__(self, p1, p2):
        self.seg = (p1.coords, p2.coords)
    def rise(self):
        rise_value = self.seg[1][1] - self.seg[0][1]
        return rise_value
ls1 = LineSegment(p1, p2)
ls1.rise()

#3. Writing a slope method that computes the slope of the line segment
class LineSegment:
    def __init__(self, p1, p2):
        self.seg = (p1.coords, p2.coords)
    def rise(self):
        rise_value = self.seg[1][1] - self.seg[0][1]
        return rise_value
def slope(self):
        run_value = self.seg[1][0] - self.seg[0][0]
        return self.rise() / run_value

#4. Writing a length method that computes the length of the line segment
class LineSegment:
    def __init__(self, p1, p2):
        self.seg = (p1.coords, p2.coords)
    
    def length(self):
        x1, y1 = self.seg[0]
        x2, y2 = self.seg[1]
        length = ((x2 - x1) ** 2 + (y2 - y1) ** 2) ** 0.5
        return length
    
#5. Creating a class Time with hours and minutes
class Time:
    def __init__(self, hours, minutes):
        self.hours = hours
        self.minutes = minutes
        
#6. Writing a constructor that sets hours and minutes to 0
    def __init2__(self, hours=0, minutes=0):
        self.hours = hours
        self.minutes = minutes

#7. Writing a method that returns the time in minutes
    def in_minutes(self):
        return self.hours * 60 + self.minutes

#8. Wrting a method that returns the string representation of a Time instance
    def __str__(self):
        time_to_print = f'{self.hours}:{self.minutes} '
        return time_to_print
    
#9. Defining a method that returns True if one time is less than or equal to another time
    def __le__(self, other):
     if self._in_minutes() <= other._in_minutes():
         return True
     else:
         return False
    
    def __ge__(self, other):
        if self._in_minutes() >= other._in_minutes():
            return True
        else:
            return False
        
    def __eq__(self, other):
        if self._in_minutes() == other._in_minutes():
            return True
        else:
            return False
    
    def __ne__(self, other):
        if self._in_minutes() != other._in_minutes():
            return True
        else:
            return False
        
#10. Writing a method that returns an instance with two times added together
    def add(self, other_time):
        total_minutes = self.in_minutes() + other_time.in_minutes()
        hours = total_minutes // 60
        minutes = total_minutes % 60
        return Time(hours, minutes)

        
        
        
        
        