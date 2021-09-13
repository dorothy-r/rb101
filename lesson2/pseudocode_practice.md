1. A method that returns the sum of two integers

Get two integers from the user.
Save them to variables.
Add one integer to the other, and save the result.
Return the result

START

SET integer1 = GET user input
SET integer2 = GET user input

SET result = integer1 + integer2
RETURN result

END

2. A method that takes an array of strings, and returns a string that is all those strings concatenated together

Given an array of strings.

Create a new empty string.
Iterate over the array.
Concatenate each string in the array to the new string.
Return the new string

START

Given an array of strings called "words"

SET new_string = ''
SET iterator = 0

WHILE iterator < length of words
  SET current_word = value within words array at index "iterator"
  new_string = new_string + current_word
  iterator = iterator + 1

RETURN new_string

END

3. A method that takes an array of integers, and returns a new array with every other element

Given an array of integers

Create a new empty array.
Iterate over the original array.
If the index number is even, push that value to the new array.
Otherwise, go to the next iteration.
Return the new array.

START

Given an array of integers called "numbers"

SET new_array = []
SET iterator = 0

WHILE iterator < length of numbers
  SET current_value = value within numbers array at index "iterator"
  IF iterator is even
    APPEND current_value to new_array
  ELSE
    go to the next iteration
  iterator = iterator + 1

RETURN new_array

END
