# Practice Problem 1
# How would your order this array of number strings by descending numeric value?

arr = ['10', '11', '9', '7', '8']
# My solution
arr.sort_by { |num| num.to_i }.reverse
# LS solution
arr.sort do |a, b|
  b.to_i <=> a.to_i
end

# Practice Problem 2
# How would you order this array of hashes based on the year of publication of
# each book, from the earliest to the latest?

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

# My solution and LS solution
books.sort_by { |hash| hash[:published] }

# Practice Problem 3
# For each of these collection objects demonstrate how you would reference the
# letter 'g'.

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
hsh2[:third].keys[0]
#Could also do:
hsh2[:third].key(0)

# Practice Problem 4
# For each of these collection objects where the value `3` occurs, demonstrate
# how you would change this to `4`.

arr1 = [1, [2, 3], 4]
arr1[1][1] = 4

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4

# Practice Problem 5
# Given the nested Hash, figure out the total age of just the male members of
# the family.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }, 
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

# My solution
total_male_age = 0
munsters.each do |_, details|
  total_male_age += details["age"] if details["gender"] == "male"
end

# LS solution
total_male_age = 0
munsters.each_value do |details|
  total_male_age += details["age"] if details["gender"] == "male"
end

# Practice Problem 6
# One of the most frequently used real-world string properties is that of
# "string substitution", where we take a hard-coded string and modify it with
# various parameters from our program.
# Print out the name, age and gender of each member of the munsters hash like this:
# (Name) is a (age)-year-old (male or female).

munsters.each do |name, details|
 # puts "#{name} is a #{details["age"]}-year-old #{details["gender"]}."
end
# note: can also use `Hash#each_pair`

# Practice Problem 7
# Given this code, what would be the final values of `a` and `b`?

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

arr # => [4, [3, 8]]
a # => 2
b # => [3, 8]

# Practice Problem 8
# Using the `each` method, write some code to output all of the vowels from the
# strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each_value do |words|
  words.each do |word|
    word.chars.each do |char|
   #   puts char if %w(a e i o u).include?(char)
    end
  end
end

# Practice Problem 9
# Given this data structure, return a new array of the same structure but with
# the sub arrays being ordered (alphabetically or numerically as appropriate)
# in descending order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |sub_arr|
  sub_arr.sort { |a, b| b <=> a }
end

# Practice Problem 10
# Given the following data structure and without modifying the original array,
# use the `map` method to return a new array identical in structure to the
# original but where the value of each integer is incremented by 1

# My first solution
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hash|
  hash.transform_values { |num| num += 1 }
end

# Solution without 'fancy' methods
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hash|
  new_hash = {}
  hash.each do |k, v|
    new_hash[k] = v + 1
  end
  new_hash
end

# Practice Problem 11
# Given the following data structure, use a combindation of methods, including
# either the `select` or `reject` method, to return a new array identical in
# structure to the original but containing only the integers that are multiples
# of 3.

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr.map do |sub_arr|
  sub_arr.select do |num|
    num % 3 == 0
  end
end

# Practice Problem 12
# Given the following data structure, and without using the Array#to_h method,
# write some code that will return a hash where the key is the first item in 
# each sub-array and the value is the second item.

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

arr.each_with_object({}) do |arr, hash|
  hash[arr[0]] = arr[1]
end

# Practice Problem 13
# Given the following data structure, return a new array containing the same
# sub-arrays as the original but ordered logically by only taking into
# consideration the odd numbers they contain. The sorted array should look like
# this: [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

arr.sort_by do |sub_arr|
  sub_arr.select { |num| num.odd? }
end

# Practice Problem 14
# Given this data structure, write some code to return an array containing the
# colors of the fruits and the sizes of the vegetables. The sizes should be
# uppercase and the colors should be capitalized. The return value should look
# like this: [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'}, 
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'}
}

hsh.map do |_, value|
  if value[:type] == 'fruit'
    value[:colors].map { |color| color.capitalize}
  elsif value[:type] == 'vegetable'
    value[:size].upcase
  end
end

# Practice Problem 15
# Given this data structure write some code to return an array which contains
# only the hashes where all the integers are even.

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# My solution
arr.select do |hash|
  hash.values.flatten.all? { |num| num.even? }
end

# LS solution
arr.select do |hsh|
  hsh.all? do |_, value|
    value.all? do |num|
      num.even?
    end
  end
end

# Practice Problem 16
=begin
A UUID is a type of identifier often used as a way to uniquely identify items...
which may not all be created by the same system. That is, without any form of
synchronization, two or more separate computer systems can create new items and
label them with a UUID with no signiticant chance of stepping on each other's
toes.
It accomplishes this feat through massive randomization. The number of possible
UUID values is approximately 3.4x10E38.
Each UUID consists of 32 hexadecimal characters, and is typically broken into 5
sections like this: 8-4-4-4-12 and represented as a string.
It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"
Write a method that returns one UUID when called with no parameters.
=end

# My solution
HEX_CHARS = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)

def generate_uuid
  uuid = ""
  sections = [8, 4, 4, 4, 12]

  sections.each do |num|
    num.times { uuid << HEX_CHARS.sample }
    uuid << "-" unless num == 12
  end
  uuid
end

# LS Solution
def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end