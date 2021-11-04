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
