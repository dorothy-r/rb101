1. What do you expect to happen when the `greeting` variable is referenced in the last line of the code below?

```ruby
if false
  greeting = "hello world"
end

greeting
```

My (wrong) answer:
The program will throw an error. The code after `if false` in the conditional will never be executed, so the variable greeting will not be initialized. Therefore, it will raise an undefined variable exception.

LS answer:
`greeting` is `nil` here, and no "undefined method or local variable" exception is thrown. Typically, when you reference an unitialized local variable, Ruby will raise an exception, stating that it's undefined. However, when you initialize a local variable within an `if` block, even if that `if` block doesn't get executed, the local variable is initialized to `nil`.

2. What is the result of the last line in the code below?

```ruby
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << 'there'

puts informal_greeting # => "hi there"
puts greetings # => :a => "hi there"
```

`informal_greeting` references the same object as `greetings[:a]`. Because the `String#<<` method modifies the original object, this changes the value of both variables that are pointing to that object. So, the value of `greetings[:a]` changes as well.

3. To drive home the alient aspects of variable scope and modification of one scope by another, consider the following similar sets of code.
   What will be printed by each of these code groups?
   A)

```ruby
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # => "one is: one"
puts "two is: #{two}" # => "two is: two"
puts "three is: #{three}" # => "three is: three"
```

B)

```ruby
def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # => "one is: one"
puts "two is: #{two}" # => "two is: two"
puts "three is: #{three}" # => "three is: three"
```

C)

```ruby
def mess_with_vars(one, two, three)
  one.gsub!("one", "two")
  two.gusb!("two", "three")
  three.gsub!("three", "one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # => "one is: two"
puts "two is: #{two}" # => "two is: three"
puts "three is: #{three}" # => "three is: one"
```

Reassignment is not mutating. In both A and B, the reassignment done within the body of the method does not affect the values of the variables outside of the method.However, because `gsub!` does mutate the caller, using it within the method in C does affect the variables outside of the method.

4. Ben was tasked to write a simple Ruby method to determin if an input string is an IP address representing dot-separated numbers, e.g. "10.4.5.11". He is not familiar with regular expressions. Alyssa supplied Ben with a method called `is_an_ip_number?` that determins if a string is a numeric string between 0 and 255 as required for IP numbers and asked Ben to use it.

```ruby
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  return true
end
```

Alyssa reviewed Ben's code and says "It's a good start, but you missed a few things. You're not returning a false condition and you're not handling the case that there are more or fewer than 4 components to the IP address (e.g. "4.5.5" or "1.2.3.4.5" should be invalid)."
Help Ben fix his code

```ruby
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end
  true
end
```
