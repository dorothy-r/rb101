# Sorting

In addition to iterating, selecting, and transforming, another common way of working with collections is to sort them into some order.
This is usually performed on arrays, since they are ordered by index and their order is important.
Strings don't have access to sorting methods, though it is easy to convert strings to arrays to use these methods.
Since Ruby 1.9, it has been possible to sort a hash, though there isn't usually a need to do this, since hash values are accessed via their keys.

## What is sorting?

Sorting is setting the items of a collection in order, according to a certain criterion.
How would we get from `[2, 5, 3, 4, 1]` to `[1, 2, 3, 4, 5]`?
Ruby provides some methods that can do this for us, e.g.:

```ruby
[2, 5, 3, 4, 1].sort # => [1, 2, 3, 4, 5]
```

The algorithm under the hood of this method is more complex than the scope of this lesson. We don't need to understand it. But we do need to understand how `sort` applies criteria to order a collection.

## Comparison

Sorting is essentially a process of _comparing_ the items in a collection with each other, and ordering them based on the results of the comparison:

```ruby
['c', 'a', 'e', 'b', 'd'].sort # => ['a', 'b', 'c', 'd', 'e']
```

How does Ruby know how to order the elements in an array?
It uses the `<=>` method, sometimes called the "spaceship" operator.

## The `<=>` Method

Any object in a collection that we want to sort must have access to a `<=>` method.
This method compares two objects of the same type and returns a `-1` if the first object is less than the second object, `0` if the two objects are equal, and `1` if the first object is greater than the second object.
The method returns `nil` if the two objects cannot be compared.
`sort` uses the return value of `<=>` to determine how to order the array's items. If `<=>` returns `nil`, then `sort` throws an error.

```ruby
2 <=> 1 # => 1
1 <=> 2 # => -1
2 <=> 2 # => 0
1 <=> 'a' # => nil

['a', 1].sort # => ArgumentError: comparison of String with 1 failed
```

When using `sort`, it's important to know how `<=>` works for the type of object you are trying to sort. You need to know two things:

1. Does that object type implement a `<=>` comparison method?
2. If so, what is the specific implementation of that method for that object type? (e.g. `String#<=>` will be implemented differently to `Integer#<=>`).

_note_ When sorting strings, the order is determined by the ASCII table. You can determine a string's ASCII position by calling `ord` on it. Some general rules:

- Uppercase letters come before lowercase
- Digits and most punctuation come before letters
- There is an extended ASCII table for accented and other characters that comes after the main ASCII table.

## The `sort` Method

When we simply call `sort` on an array, it uses the `<=>` method to compare the items being sorted.
We can also call it with a block, which allows us to sort the items in different ways. The block takes two arguments (the two items being compared), and the return value has to be `-1`, `0`, `1`, or `nil`.
Below, the first example does what `sort` would do without a block, and the second shows what happens when we switch the order in which the items are compared: the array is sorted in descending order.

```ruby
[2, 5, 3, 4, 1].sort { |a, b| a <=> b }  # => [1, 2, 3, 4, 5]

[2, 5, 3, 4, 1].sort { |a, b| b <=> a }  # => [5, 4, 3, 2, 1]
```

You can add more code to the block, as long as it returns one of the 4 values listed above.

## The `sort_by` Method

This method is similar to `sort`, but usually called with a block. The code in the block determines how the items are compared.
In this example, the array is sorted using the character at index`1` of each string, so only those characters are compared; the others are ignored:

```ruby
['cot', 'bed', 'mat'].sort_by do |word|
  word[1]
end
# => ["mat", "bed", "cot"]
```

Generally, there isn't a need to sort hashes, but if you wanted to, calling `sort_by` on it would work. Two arguments would need to be passed to the block in that case--the key and the value. So lets say we wanted to sort the hash belows by age. We could do this:

```ruby
people = { Kate: 27, john: 25, Mike: 18 }

people.sort_by do |_, age|
  age
end
# => [[:Mike, 18], [:john, 25], [:Kate, 27]]
```

This method always returns an array, even when called on a hash.
Can we sort this has by name? Need to check the docs to see if there is a `Symbol#<=>` method, and how it works.
Doing this, we see that it works by comparing the symbols after calling `to_s` on them. So we can sort the hash by name, and it will work just like sorting strings. To deal with the fact that one name is not capitalized, call the `Symbol#capitalize` method in the block, so that the keys will be capitalized when compared:

```ruby
people.sort_by do |name, _|
  name.capitalize
end
# => [[:john, 25], [:Kate, 27], [:mike, 18]]
```

## Other methods which use comparison

Array also has destructive methods equivalent to `sort` and `sort_by`: `sort!` and `sort_by!`. These return the original collection, sorted, rather than a new collection.

Other Ruby methods that use comparison (meaning they need to implement a `<=>` method):

- min
- max
- minmax
- min_by
- max_by
- minmax_by

These methods can be found in the `Enumerable` module, and can be called on arrays and hashes.
