1. What would you expect the code below to print out?

```ruby
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
```

It would print out:

```
1
2
2
3
```

Array#uniq is not a mutating method. It returns a new array with the unique items from the original. It does not modifiy the orignal array. Since that new array was not stored in a variable, and in particular, since the variable numbers was not reassigned to it, numbers still refers to the original array, so calling `puts` on it will print all items in the original array.

2. Describe the difference between `!` and `?` in Ruby. And explain what would happen in the following scenarios:

Both of these characters have a few meanings in Ruby. `!` is the boolean 'NOT' operator, that is it returns the opposite boolean value of whatever comes after it. It is also used in method names to indicate that a method will mutate the caller.
`?` is a part of the syntax for a ternary statement. It is also used in method names to indicate that a method returns a boolean value.

1. What is `!=` and where should you use it?
   `!=` is a comparison operator, meaning 'is not equal to'. It returns a boolean value. You should use it in conditional statements: `if guess != correct_answer`, for example.

2. put `!` before something, like `!user_name`
   This returns the opposite of the object's boolean equivalent. If `user_name` has a value of false or nil, `!user_name` will return `true`. Otherwise, it will return `false`.

3. put `!` after something, like `words.uniq!`
   This is a naming convention that indicates that the method (here, `uniq!`) is destructive and will modify the object it is called on (`words`, in this case). This `!` is _not_ Ruby syntax. Adding a `!` to the end of a method name doesn't make it a destructive method. When we see a method name ending in `!` we can usually expect that it is destructive, but this may not be true. Also, not all destructive methods end in `!` so it is always a good idea to check the documentation to see if a method actually is destructive.

4. put `?` before something
   In a ternary statement, the `?` comes in between the statement being evaluated and the branch that will be executed if the statement is true:
   `num == 5 ? puts 'great' : puts 'eh'`
   But just putting `?` before an object doesn't do anything

5. put `?` after something
   This is another naming convention that indicates that the method returns a boolean value (`true` or `false`). As with method names ending in `!`, this is _not_ Ruby syntax. You still need to check the method implementation to know what it is actually doing.

6. put `!!` before something, like `!!user_name`
   This returns the object's boolean equivalent. If it is truthy, it will return `true` and if falsy, return `false`.

7. Replace the word "important" with "urgent in this string:

```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```

```ruby
advice.gsub!('important', 'urgent')
```

4. The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ. What do the following method calls do (assume we reset `numbers` to the original array between method calls)?

```ruby
numbers = [1, 2, 3, 4, 5]

numbers.delete_at(1) # now numbers = [1, 3, 4, 5]
numbers.delete(1) # now numbers = [2, 3, 4, 5]
```

In both of these cases, the array _is_ modified in place (despite the method names not ending in `!`), and the removed item is the method's return value.

5. Programmatically determine if 42 lies between 10 and 100. (hint: use Ruby's range object in your solution)

```ruby
(10..100).include?(42)
# or
(10..100).cover?(42)
```

Because both ends of the range are numeric, `include?` behaves like `cover?`

6. Starting with the string:

```ruby
famous_words = "seven years ago..."
```

show two different ways to put the expected "Four score and " in front of it.

```ruby
"Four score and " + famous_words
"Four score and " << famous_words
famous_words.prepend("Four score and ") # from LS solution
```

7. If we build an array like this:

```ruby
flintstones = ["Fred", "Wilma"]
flinstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
```

We will end up with this "nested" array":

```ruby
flintstones = ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
```

Make this into an un-nested array

```ruby
flintstones.flatten!
```

8. Given the hash below, turn it into an array containing only two elements: Barney's name and number

```ruby
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flintsones.keep_if {|key, value| key == "Barney"}.flatten
flintstones.assoc("Barney") # LS solution
```
