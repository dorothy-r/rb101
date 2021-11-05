# 1. Turn the array below into a hash where the names are the keys and the
# values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# My solution:
flintstones_hash = flintstones.each_with_object({}) do |name, hash|
  hash[name] = flintstones.index(name)
end

# LS solution:
flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

# 2. Add up all of the ages from the Munster family hash:
ages = { "Herman" => 32, "Lily", => 30, "Grandpa" => 5842, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# My solution:
ages.values.sum  # => 6174

# LS solution 1:
total_ages = 0
ages.each { |_,age| total_ages += age }
total_ages # => 6174

# LS solution 2:
ages.values.inject(:+) # => 6174

# 3. In the age hash below, remove people with age 100 and greater:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# My solution:
ages.reject! { |key, value| value >= 100 }

# LS solution:
ages.keep_if { |_, age| age < 100 }
# or
ages.select! { |_, age| age < 100 } 
# note: `select!` and its alias `fliter!` return `nil` if no changes are made

# 4. Pick out the minimum age from our current Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# My solution and LS solution:
ages.values.min

# 5. In the following array, find the index of the first name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# My solution
flintstones.index { |name| name.start_with?("Be") }

# LS solution
flinstones.index { |name| name[0, 2] == "Be" }

# 6. Amend this array so that the names are all shortened to just the first 3 characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# My solution and LS solution:
flintstones.map! { |name| name[0, 3]}

# 7. Create a hash that expresses the frequency with which each letter ocurs in this string:
statement = "The Flintstones Rock"

# My solution:
frequency_hash = Hash.new(0)
statement.delete('^A-Za-z').chars.each do |char|
    frequency_hash[char] += 1
end

# LS solution
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

# 8. What happens when we modify an array while we are iterating over it?
# What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
=begin
Here is my guess:
So this code would pass the first element, 1, into the block, print it to the
screen, and remove it from the array. At this point the `numbers` array is
[2, 3, 4]. The second element is now 3. I think 3 then gets passed to the block
and printed to the screen. 2 is then removed from `numbers`, and now `numbers`
only has two elements, and will not continue iterating.
So the output will be: 1 3. And the return value is the modified original array:
[3, 4]. I will try it in irb now.
And it looks like that is what happens.
=end

# What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

=begin
In this code, the first element, 1, is passed to the block and printed to the
screen. The last element, 4, is then permanently removed from the array. Next,
the second element is passed to the block and printed to the screen. The last
element, 3, is permanently removed from the array. At this point, there are no
more elements in the array, so iteration stops. The output is: 1 2. And the
return value is [1, 2].
=end

=begin
LS explanation:
Our array is being changed as we go (shortened and shifted), and the loop
counter used by `#each` is compared against the current length of the array
rather than its original length.
In our first example, the removal of the first item in the first pass changes
the value found for the second pass.
In our second example, we are shortening the array each pass just as in the
first example... but the items removed are beyond the point we are sampling
from in the abbreviated loop.
In both cases we see that iterators DO NOT work on a copy of the original array
or from stale meta-data (length) about the array. They operate on the array in
real time.
=end

# 9. As we have seen previously, we can use some built-in string methods to
# change the case of a string. A notably missing method is something provided
# in Rails, but not in Ruby itself... `titleize`. This method in Ruby on Rails
# creates a string that has each word capitalized as it would be in a title.
# For example, the string `the flintstones rock` would be `The Flintstones Rock`
# Write your own version of the Rails `titleize` implementation.

# My solution
def titleize(str)
  str.split.map {|word| word.capitalize }.join(' ')
end

# LS solution
words.split.map { |word| word.capitalize }.join(' ')

# 10. Given the `munsters` hash below, modify the hash such that each member of
# the Munster family has an additional "age_group" key that has one of three
# values describing the age group the family member is in (kid, adult, or
# senior). Note: a kid is 0 - 17, an adult is 18 - 64, and a senior is 65+. 

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

# My solution:
munsters.values.map do |person|
  case person["age"]
  when (0..17)
    person["age_group"] = "kid"
  when (18..64)
    person["age_group"] = "adult"
  else
    person["age_group"] = "senior"
  end
end

# LS solution:
munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else 
    details["age_group"] = "senior"
  end
end