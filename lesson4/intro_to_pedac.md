# Introduction to PEDAC

The goal of the PEDAC process is to help identify and avoid the pitfalls of coding without intent.
This introductory guide is geared towards the 109 interview assessment, and focuses on the "understand the problem" and "data structure/algorithm" steps.
While jumping straight to code may seem faster, the PEDAC process saves time and lets you solve **complex** problems efficiently.

## P - [Understand the] **P**roblem

This is the most important part of the process, and in a sense, it continues throughout the process. It is important to spend enough time in this step, and not rush through it.
There are 3 substeps involved in understanding the problem:

1. Read the problem description
2. Check the test cases, if any.
3. If any part of the problem is unclear, ask the interviewer to clarify the matter.

Let's do this with a sample problem:

1. Description:
   Given a string, write a method `change_me` which returns the same string but with all the words in it that are palindromes uppercased.

2. Test cases:

```ruby
change_me("We will meet at noon") == "We will meet at NOON"
change_me("No palindromes here") == "No palindromes here"
change_me("") == ""
change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"
```

3. Potential clarifying questions: -**What is a palindrome?** The interviewer can answer this -**Should the words in the string remain the same if they already use uppercase?** In this problem, the test cases answer this question -**How should I deal with empty strings provided as input?** The test cases also answer this question -**Can I assume that all inputs are strings?** This is not addressed in the test cases, so you can ask the interviewer -**Should I consider letter case when deciding whether a word is a palindrome?** Again, the test cases don't answer this, so it is a good question for the interviewer. -**Do I need to return the same string object or an entirely new string?** This is one of the most important questions to ask, and one of the most overlooked. A very good question to ask the interviewer. In this case, you should return an entirely new string. -**Always verify your assumptions either by looking at the test cases or by asking the interviewer.** Some assumptions can be verified by looking at the problem description or the test cases. If you don't find clarification there, you should ask the interviewer.

Once you have understood the problem, write down the inputs and outputs as well as the problem's rules (its explicit and implicit requirements).
Explicit requirements are clearly stated in the program description. Implicit requirements can be extrapolated from examples, test cases, etc.
With this problem, you could write this:

```ruby
# input: string
# output: string (not the same object)
# rules:
#     Explicit requirements:
#       - every palindrome in the string must be converted to uppercase. (Reminder: a palindrome is a word that reads the same forwards and backward.)
#       - Palindromes are case sensitive ("Dad" is not a palindrome, but "dad" is).
#     Implicit requirements:
#       - the returned string shouldn't be the same string object
#       - if the string is an empty string, the result should be an empty string
```

## E - **E**xamples / Test cases

Test cases can confirm or refute assumptions, and help answer questions about implicit requirements.
In the RB109 interveiw, test cases wil be provided.
So the guide doesn't focus on this step.

## D/A - **D**ata Structure / **A**lgorithm

These two steps are often paired, since data structures influence your algorithm.
Data structures help us reason with data logically, and figure out how to interact with data at the implementation level.
Thinking about how to structure your data is part of the problem solving process.
Use cases for various data structures are usually easy to identify. However, designing the correct algorithm with enough detail is much more challenging.

Here is another sample problem. Try to do the "P" step on your own:

1. Description:
   Given a string, write a method `palindrome_substrings` which returns all the substrings from a given string which are palindromes. Consider palindrome words case sensitive.

2. Test cases:

```ruby
palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
palindrome_substrings("palindrome") == []
palindrome_substrings("") == []
```

3. Clarifying questions:
   -How should I deal with empty strings?
   They return an empty array
   -Should I consider the case of the characters?
   Yes, the palindrome words are case sensitive
   -What should the method return?
   An array of strings
   -How to deal with non-string input?
   Not necessary for this problem

4. Summary

```ruby
=begin
input: string
output: array of strings
rules:
    Explicit requirements:
      - Return every substring from the string that is a palindrome
      - Palindromes are case sensitive
    Implicit requirements:
      - Return an array that includes all appropriate substrings
      - An empty string should return an empty array, as should a string with no palindromic substrings.
=end
```

We've understood the problem, and have had examples provided in the form of test cases.
The **D**ata Structure we'll use is an array, since that is the desired output.

Now it is time to work on the algorithm. An algorithm is a logical sequence of steps for accomplishing a task or objective. Keep the algorithm abstract and high-level at first (avoid language-specific implementation details), and revisit it throughout the coding process.
Here's an example of a high-level algorithm for this problem:
-Initialize an result variable to an empty array
-Create an array named substring_arr that constains all of the substrings of the input string that are at least 2 characters long.
-Loop through the words in the substring_arr array.
-If the word is a palindrome, append it to the result array.
-Return the result array.

An issue with the above algorithm is that it does not go into enough detail regarding the hardest part of the problem: finding all the substrings for a given string.
If you start writing code based on an algorithm, and realize that one of the steps is difficult and not fully developed, it is ideal to return to the algorithm and try to come up with a more detailed solution. This is much more efficient than trying to solve it _while_ coding.
You can use the "high-level" algorithm to write some code, while leaving some of the implementation undefined:

```ruby
def palindrome_substring(str)
  result = []
  substrings_arr = substrings(str)
  substrings_arr.each do |substring|
    result << substring if is_palindrome?(substring)
  end
  result
end
```

So in the above code, the methods `substrings` and `is_palindrome?` have not been defined yet. It is a good idea to return to the algorithm to determine how they will work.
When trying to come up with an algorithm, try simplifying the problem by using a small, concrete example. In this case, how would you get all of the substrings of a short word like 'halo'?
Thinking about how that would work can get you to a more general algorithm.
Here is what an algorithm for the substrings method might look like:

-Create an empty array called `result` that will contain all required substrings
-Create a `starting_index` variable (value `0`) for the starting index of a substring
-Start a loop that iterates over `starting_index` from `0` to the length of the string minus 2
-Create a `num_chars` variable (value `2`) for the length of a substring
-Start an inner loop that iterates over `num_chars` from `2` to `string.length - starting_index`
-Extract a substring of length `num_chars` from `string` starting at `starting_index`
-Append the extracted substring to the `result` array
-Increment the `num_chars` variable by `1`
-End the inner loop
-Increment the `starting_index` variable by `1`
-End the outer loop
-Return the `result` array

Formal pseudocode isn't always needed, but can be a helpful step in between informal pseudocode and the final program code.
Here is how the algorithm for `substring` might be implemented in code:

```ruby
def substrings(str)
  result = []
  starting_index = 0

  while (starting_index <= str.length -2)
    num_chars = 2
    while (num_chars <= str.length - starting_index)
      substring = str.slice(starting_index, num_chars)
      result << substring
      num_chars += 1
    end
    starting_index += 1
  end
  result
end
```

Finally, we can write an algorithm for determining whether a string is a palindrome:

- Check whether the string value is equal to its reversed value.
  And translate it to code:

```ruby
def is_palindrome?(str)
  return str == str.reverse
end
```

Here is the complete informal pseudocode for this problem:

```ruby
# input: a string
# output: an array of substrings
# rules: palindrome words should be case sensitive, meaning "abBA"
#        is not a palindrome

# Algorithm:
#  substrings method
#  =================
#    - create an empty array called `result` that will contain all required substrings
#    - create a `starting_index` variable (value `0`) for the starting index of a substring
#    - start a loop that iterates over `starting_index` from `0` to the length of the string minus 2
#      - create a `num_chars` variable (value `2`) for the length of a substring
#      - start an inner loop that iterates over `num_chars` from `2` to `string.length - starting_index`
#        - extract a substring of length `num_chars` from `string` starting at `starting_index`
#        - append the extracted substring to the `result` array
#        - increment the `num_chars` variable by `1`
#      - end the inner loop
#      - increment the `starting_index` variable by `1`
#    - end the outer loop
#    - return the `result` array

#  is_palindrome? method
#  =====================
# - Inside the `is_palindrome?` method, check whether the string
#   value is equal to its reversed value. You can use the
#   String#reverse method.

#  palindrome_substrings method
#  ============================
#  - initialize a result variable to an empty array
#  - create an array named substring_arr that contains all of the
#    substrings of the input string that are at least 2 characters long.
#  - loop through the words in the substring_arr array.
#  - if the word is a palindrome, append it to the result
#    array
#  - return the result array
```

## C - **C**ode

This step is about translating our solution algorithm into code.
Here, we can think about implementing the algorithm in the context of the programming language we are using (features and constraints, characteristcs of data structures, built-in functions/methods, and syntax).
Thanks to our algorithm, we can code _with intent_ here.

And here is the final code for this problem:

```ruby
def substrings(str)
  result = []
  starting_index = 0;

  while (starting_index <= str.length - 2)
    num_chars = 2
    while (num_chars <= str.length - starting_index)
      substring = str.slice(starting_index, num_chars)
      result << substring
      num_chars += 1
    end
    starting_index += 1
  end
  result
end

def is_palindrome?(str)
  str == str.reverse
end

def palindrome_substrings(str)
  result = []
  substrings_arr = substrings(str)
  substrings_arr.each do |substring|
    result << substring if is_palindrome?(substring)
  end
  result
end

p palindrome_substrings("supercalifragilisticexpialidocious"); # ["ili"]
p palindrome_substrings("abcddcbA");   # ["bcddcb", "cddc", "dd"]
p palindrome_substrings("palindrome"); # []
p palindrome_substrings("");           # []
```

Once you have written a plain English solution to the problem, you can code it much more easily. If you can't write an algorithm, you won't be able to code the problem either.

### Test Frequently

Testing isn't one of the PEDAC steps, but it is still an important part of writing code. Test early and often when writing the actual code.
Creating test cases as you go along is important. Use the examples given for the main problem, too.
You can test to see how the various steps within the code are working as you are writing.
This will allow you to find bugs in your code as soon as possible.
