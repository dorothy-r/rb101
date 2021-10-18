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

```ruby
def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end
```

Using a while loop tests whether the input is greater than 0 before executing the code within the loop. This prevents a zero-division error or an infinite loop.

Bonus 1: What is the purpose of the `number % divisor == 0`?
This checks to see if `number` can be evenly divided by `divisor` with no remainder. That way, there won't be any repeats in the factors array.

Bonus 2: What is the purpose of the second-to-last line in the method (the `factors` before the method's `end`)?
In Ruby, methods return the value of last statement executed (unless there is an explicit `return` statement in the method). Putting `factors` on the line just before `end` means that this method will return the value associated with `factors`, instead of the return value of the while loop (which is `nil`).

4. Alyssa was asked to write an implementation of a rolling buffer. Elements are added to the rolling buffer and if the buffer becomes full, then new elements that are added will displace the oldest elements in the buffer.

She wrote two implementations saying, "Take your pick. Do you like `<<` of `+` for modifying the buffer?" Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?

```ruby
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end
```

The difference between the two methods is that method 1 mutates the existing array, `buffer`, while, method 2 creates a new array, `buffer`, by combining the input array with an array containing the new element. So method 1 mutates the input argument (`buffer`) and method 2 does not mutate the input argument (`input_array`). Both methods have the same return value. I'd guess that method 1 would be a better choice from a performance standpoint? Seems like a better idea to modify the existing array than to keep creating new ones each time an element is added.

5. Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator. A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached.
   Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?

```ruby
limit = 15

def fib(first_num, second_num)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0,1)
puts "result is #{result}"
```

The problem with the code is that the variable `limit` is initialized outside of the method, and is not accessible within the method definition. To fix this, `limit` could eith be initialized within the method definition (if it is not needed elsewhere in the code) or it could be passed as an argument, if another parameter was added to the method definition.

6. What is the output of the following code?

```ruby
answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
```

It will output 34 (42 - 8). The return value of `mess_with_it(answer)` is captured by the `new_answer` variable. However, the value of `answer` is still 42. So `answer - 8` is 34.

7. One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:

```ruby
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end
```

After writing this method, he typed the following... and before Grandpa could stop him, he hit the Enter key with his tail:

```ruby
mess_with_demographics(munsters)
```

Did the family's data get ransacked? Why or why not?

Yes, it did! Hashes are mutable objects. The variable `munsters` continues to point to the original hash--it is not reassigned in the method. The values _within_ the hash are reassigned in the method, but the hash itself is not. So the changes made to its values inside the method are permanent.

8. Method calls can take expressions as arguments. Suppose we define a method called `rps` as follows, which follows the classic rules of rock-paper-scissors, but with a slight twist that it declares whatever hand was used in the tie as the result of that tie.

```ruby
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end
```

What is the result of the following call?

```ruby
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")

# 1st reduction: rps(rps("paper", "rock"), "rock")
# 2nd reduction: rps("paper", "rock")
# result: "paper"
```

The result is "paper"

9. Consider these two simple methods:

```ruby
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end
```

What would be the return value of the following method invocation?

```ruby
bar(foo)
```

The return value is "no"
