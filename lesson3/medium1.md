1. Write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:

```
The Flintstones Rock!
 The Flintstones Rock!
   The Flintsones Rock!
    ...
```

```ruby
10.times { |num| puts (" " * num) + "The Flintstones Rock!" }
```

2. The result of the following statement will be an error:

```ruby
puts "the value of 40 + 2 is " + (40 + 2)
```

Why is this and what are two possible ways to fix this?

This statement throws an error because you can't concatenate a string and an integer in Ruby. There is no implicit conversion to string in this situation. To fix it, either explicitly convert the number to a string using `Int#to_s`, or use string interpolation:

```ruby
puts "the value of 40 + 2 is " + (40 + 2).to_s
# or
puts "the value of 40 + 2 is #{40 + 2}"
```

3. Alan wrote the following method, which was intended to show all of the factors of the input number:

```ruby
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end
```

Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. How can you make this work without using `begin`/`end`/`until`?
