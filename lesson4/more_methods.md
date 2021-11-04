# More methods

This assignments will deconstruct how some common built-in collection methods work.
It is always a good idea to consult the documentation when learning about a method!
Here are a few common Ruby methods:

## `Enumerable#any?`

```ruby
[1, 2, 3].any? do |num|
  num > 2
end
# => true
```

This method evaluates the block for _truthiness_ and returns `true` if the block returns a "truthy" value for _any_ of the elements in the collection.
It can also be used with a hash, but requires two parameters in that case (to access the key and the value):

```ruby
{ a: "ant", b: "bear", c: "cat" }.any? do |key, value|
  value.size > 4
end
# => false
```

## `Enumerable#all?`

This method is similar to `any?`, but only returns `true` if the block returns a truthy value for every iteration:

```ruby
# Called on an array
[1, 2, 3].all? do |num|
  num > 2
end
# => false

# Called on a hash
 a: "ant", b: "bear", c: "cat" }.all? do |key, value|
  value.length >= 3
end
# => true
```

## `Enumerable#each_with_index`

This method is nearly identical to `each`. It also executes the code within the block, ignores its return value, and returns the original collection.
The difference is that `each_with_index` takes a second argument, which represents the index of each element.
It can also be called on a hash, in which case the first argument represents an array containing the key and the value:

```ruby
# Called on an array
[1, 2, 3].each_with_index do |num, index|
  puts "The index of #{num} is #{index}"
end

# The index of 1 is 0.
# The index of 2 is 1.
# The index of 3 is 2.
# => [1, 2, 3]

# Called on a hash
{ a: "ant", b: "bear", c: "cat" }.each_with_index do |pair, index|
  puts "The index of #{pair} is #{index}."

# The index of [:a, "ant"] is 0.
# The index of [:b, "bear"] is 1.
# The index of [:c, "cat"] is 2.
# => { :a => "ant", :b => "bear", :c => "cat" }
```

## `Enumerable#each_with_object`

In addition to taking a block, `each_with_object` also takes a method argument--a collection object that will be returned by the method.
The block itself takes two arguments: the first block argument represents the current element, and the second represents the collection object that was passed in to the method. Here is an example:

```ruby
[1, 2, 3].each_with_object([]) do |num, array|
  array << num if num.odd?
end
# => [1, 3]
```

So above, the block variable `array` is initialized to the empty array passed in as a method argument. The code inside the block can then manipulate the array; in this case, appending the current `num` if it is odd.
This method can also be called on a hash. Again, the first block argument becomes an array containing the key and value, though you can also use parentheses in the first block argument to represent the key and value:

```ruby
# With key-value pairs as arrays
{ a: 'ant', b: 'bear', c: 'cat' }.each_with_object([]) do |pair, array|
  array << pair.last
end
# => ["ant", "bear", "cat"]

# With key and value in parentheses
{ a: 'ant', b: 'bear', c: 'cat' }.each_with_object({}) do |(key, value), hash|
  hash[value] = key
end
# => { "ant" => :a, "bear" => :b, "cat" => :c }
```

Stick to one format when coding, but it is good to be able to recognize alternative syntax.

## `Enumerable#first`

`first` doesn't take a block; it does take an optional argument representing the number of elements to return.
If no argument is given, it returns only the first element. If given an argument `n`, it returns the first `n` elements.
It can be called on arrays and hashes, though in practice, it is rarely used with hashes.
Since Ruby 1.9, hashes in Ruby preserve their order, so you can call `first` on a hash, even though it doesn't make much sense.
Also, the return value of calling `first` on a hash is a nested array:

```ruby
# Called on an array
[1, 2, 3].first
# => 1

# Called on a hash
{ a: "ant", b: "bear", c: "cat" }.first(2)
# => [[:a, "ant"], [:b, "bear"]]
```

## `Enumerable#include?`

`include?` doesn't take a block, but it does require one argument. It returns `true` if the argument is in the collection, and `false` if it isn't.

```ruby
# On an array
[1, 2, 3].include?(1)
# => true
```

`include?` can be called on a hash, but it only checks the keys, not the values. In practice, you would use `Hash#key?` or `Hash#has_key?` instead, since it makes what you are doing more clear. (The Ruby style guide recommends `key?` over `has_key?`
To find out if a value exists in a hash, use the `Hash#value?` or `Hash#has_value?` methods. (Similarly, the style guide recommends `value?` instead of `has_value?`)

## Enumerable#partition

This method takes a block, and divides elements in the current collection into two collections, depending on the block's return value (`true`/`false`).
The method returns a nested array, containing the two arrays created based on the block's return value:

```ruby
[1, 2, 3].partition do |num|
  num.odd?
end
# [[1, 3], [2]]
# the elements that return `true` are in the first array, `false` in the second

# Can capture the inner arrays with parallel variable assignment:
odd, even = [1, 2, 3].partition { |num| num.odd? }

odd # => [1, 3]
even # => [2]

# Can be used on a hash, but will always return an array.
long, short = { a: "ant", b: "bear", c: "cat" }.partition do |key, value|
  value.size > 3
end
# => [[[:b, "bear"]], [[:a, "ant"], [:c, "cat"]]]

# Can be transformed back to a hash with `Array#to_h`:
long.to_h # => { :b => "bear" }
short.to_h # => { :a => "ant", :c => "cat" }
```

## Summary

We've looked at several different collection methods. You can find these and more in the Ruby documentation.
Method docs will usually include:

- Method signatures (which will indicate whether the method takes arguments and/or a block, and what it returns)
- A brief description of how it is used
- Some code examples

Taking the time to read a method's documentation can give us a thorough understanding of how it works.
