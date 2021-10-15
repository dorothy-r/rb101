1. In this has of people and their age, see if "Spot" is present:

```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402. "Eddie" => 10 }

ages.include?("Spot")
# these also work:
ages.member?("Spot")
ages.key?("Spot")
ages.has_key?("Spot")
```

2. Start with this string:

```ruby
munsters_description = "The Munsters are creepy in a good way."
```

Convert the string in the following ways (code will be executed on original `munsters_description` above):

```ruby
"tHE mUNSTERS ARE CREEPY IN A GOOD WAY." == munsters_description.swapcase
"The munsters are creepy in a good way." == munsters_description.capitalize
"the munsters are creepy in a good way." == munsters_description.downcase
"THE MUNSTERS ARE CREEPY IN A GOOD WAY." == munsters_description.upcase
```

3. We have most of the Munster family in our age hash:

```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402. "Eddie" => 10 }
```

Add ages for Marilyn and Spot to the existing hash:

```ruby
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge!(additional_ages)
```

4. See if the name "Dino" appears in the string below:

```ruby
advice = "Few things in life are as important as hous training your pet dinosaur."

advice.include?("Dino")
# LS Solution:
advice.match?("Dino")
```

5. Show an easier way to write this array:

```ruby
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

6. How can we add the family pet "Dino" to our usual array:

```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones << 'Dino'
```

7. In the previous example, we could have also used either `Array#concat` or `Array#push` to add Dino to the family. How can we add multiple items to our array? (Dino and Hoppy)

```ruby
flintstones.push('Dino', 'Hoppy)'
flintstone.concat(['Dino', 'Hoppy'])
```

8. Shorten the following sentence:

```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```

Review the `String#slice!` documentation, and use that method to make the return value "Few things in life are as important as ". But leave the `advice` variable as "house training your pet dinosaur.".

```ruby
advice.slice!(0..38)
# LS Solution:
advice.slice!(0, advice.index('house'))
```

As a bonus, what happens if you use the `String#slice` method instead?
`slice` is the non-destructive version of `slice!`. It would still return the same string, but the original string pointed to by the `advice` variable would not be altered.

9. Write a one-liner to count the number of lower-case 't' characters in the following string:

```ruby
statement = "The Flintstones Rock!"

statement.count('t')
```

10. If we had a table of Flintstone family members that was forty characters in width, how could we easily center that title above the table with space?

```ruby
title = "Flintstone Family Members"

title.center(40)
```
