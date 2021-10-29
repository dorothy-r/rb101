# Looping

It is common to perform an action on each element of a collection. Loops can be used to perform an action on many or all of the elements in a collection, avoiding the need to write a lot of repetitive code:

```ruby
arr = [1, 2, 3, 4, 5]
counter = 0

loop do
  arr[counter] += 1
  counter += 1
  break if counter == arr.size
end

arr # => [2, 3, 4, 5, 6]

#much better and more scalable than:
arr = [1, 2, 3, 4, 5]
arr[0] += 1
arr[1] += 1
arr[2] += 1
arr[3] += 1
arr[4] += 1
arr # => [2, 3, 4, 5, 6]
```

## Controlling a Loop

In Ruby, the `Kernel#loop` method creates a simple loop. The method takes a block, which will be executed each time the loop performs an iteration.
This code will print `Hello!` infinitely:

```ruby
loop do
  puts 'Hello!'
end
```

Adding the reserved word `break` at the end of the block means the loop will only iterate once. Executing `break` immediately exits the loop.
To loop more than once, use a conditional statement so that `break` is called when a specific condition occurs.
In this example, we will exit the loop when `number` equals 5:

```ruby
loop do
  number = rand(1..10)
  puts 'Hello!'
  if number == 5
    puts 'Exiting...'
    break
  end
end
```

### Iteration

We can control exactly how many times a loop will iterate by using a variable that tracks the number of iterations performed.
Using this variable, we can tell `loop` to execute a specific number of times by incrementing the variable by 1 during each iteration:

```ruby
counter = 0

loop do
  puts 'Hello!'
  counter += 1
  break if counter == 5
end
```

Note that the counter must be initialized **outside** of the loop to keep it from being reassigned to 0 on each iteration!

#### Break Placement

In the above example, placing `break` on the last line in the loop mimics the behavior of a "do/while" loop.
In this type of loop, the code within the block is guaranteed to execute at least once.
Placing `break` on the first line of a loop mimics the bahavior of a `while` loop. The code below `break` may or may not execute, depending on the condition:

```ruby
counter = 0

loop do
  break if counter == 0
  puts 'Hello!'
  counter += 1
end
```

#### Next

The `next` keyword is another tool to help control loops. It tells the loop to skip the rest of the _current_ iteration and begin the _next_ one.
In this example, we skip the iterations where the `counter` variable is an odd number:

```ruby
counter = 0

loop do
  counter += 1
  next if counter.odd?
  puts counter
  break if counter > 5
end
```

Note that incrementing `counter` has to take place before the `next` statement, to avoid an infinite loop.

## Iterating Over Collections

Here's a look at using loops to iterate over collections

### String

This loop iterates over a string and prints each character:

```ruby
alphabet = 'abcdefghijklmnopqrstuvwxyz'
counter = 0

loop do
  break if counter >= alphabet.size
  puts alphabet[counter]
  counter += 1
end
```

Having `counter` start at 0 allows us to use that variable to reference each letter based on its index.

### Array

Iterating over an array with `loop` works the same as it does with a string:

```ruby
colors = ['green', 'blue', 'purple', 'orange']
counter = 0

loop do
  break if counter == colors.size
  puts "I'm the color #{colors[counter]}!"
  counter += 1
end
```

### Hash

Using `loop` to iterate over a hash is more complicated, since they use key-value pairs rather than a zero-based index. Thus, we can't directly use the `counter` variable in the same way.
Creating an array of the keys in the hash, using `Hash#keys` allows us to iterate over the hash:

```ruby
number_of_pets = {
  'dogs' => 2
  'cats' => 4
  'fish' => 1
}
pets = number_of_pets.keys # => ['dogs', 'cats', 'fish']
counter = 0

loop do
  break if counter == number_of_pets.size
  current_pet = pets[counter]
  current_pet_number = number_of_pets[current_pet]
  puts "I have #{current_pet_number} #{current_pet}!"
  counter += 1
end
```

This is a two-step process, involving iterating over the array of keys(`pets`) and assigning the value to the `current_pet` variable, and then using that variable to access each value in the hash.
