#!/bin/python3

import math
import os
import random
import re
import sys


#
# Complete the 'romanizer' function below.
#
# The function is expected to return a STRING_ARRAY.
# The function accepts INTEGER_ARRAY numbers as parameter.
#


def romanizer(numbers):
    # Write your code here
    # Declraing Integer to Roman Numerals
    number_to_roman_numerals = {
        1:'I', 4:'IV', 5:'V', 9:'IX', 10:'X', 40:'XL', 50:'L', 90:'XC', 100:'C',400:'CD',500:'D',900:'CM',1000:'M'
    }
    values = sorted(number_to_roman_numerals.keys(), reverse=True)
     
    # Convert each number in the input list to RMs
    roman_array = []
    for num in numbers:
        roman = ""
        for value in values:
            while num >= value:
                roman += number_to_roman_numerals[value]
                num -= value
        roman_array.append(roman)
    return roman_array
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    numbers_count = int(input().strip())

    numbers = []

    for _ in range(numbers_count):
        numbers_item = int(input().strip())
        numbers.append(numbers_item)

    result = romanizer(numbers)

    fptr.write('\n'.join(result))
    fptr.write('\n')

    fptr.close()
