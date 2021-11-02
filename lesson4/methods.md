# Methods

Using loops to iterate over a collection gets repetitive. Ruby has several built-in methods that make it easier to work with collections. Here, we will specifically look at `each`, `select`, and `map`.

## `each`

So far, we have learned to iterate over a collection using a loop, like this:

```ruby
numbers = [1, 2, 3]
counter = 0

loop do
  break if counter == numbers.size
  puts numbers[counter]
  counter += 1
end
```

Iterating over a collection is very common, and Ruby provides a method to do it. `each` is functionally equiavalent to `loop` and accomplishes the same task more simply.
This example has the same result as the `loop` above:

```ruby
[1, 2, 3].each do |num|
  puts num
end
```

Here, the `each` method is called on the array `[1, 2, 3]`. `each` takes a block, which is the code between `do ... end`.
The code within the block is executed upon each iteration. The block argument (`num` in this case) represents the value of the current element in the array.
When working with an array, `each` sends the block only one argument per iteration.
Using `each` with a hash requires two arguments, to represent both the key and the value on each iteration:

```ruby
hash = { a: 1, b: 2, c: 3 }

hash.each do |key, value|
  puts "The key is #{key} and the value is #{value}"
end
```

One of the main differences between using `each` and using `loop` is that `each` returns _the original collection_.

## `select`

We learned how to perform selection learning `loop`, but arrays and hashes also have a built-in method for performing selection.
The `select` method is much simpler than using `loop`:

```ruby
[1, 2, 3].select do |num|
  num.odd?
end
```

`select` evaluates the **return value of the block**. On each iteration, the block returns a value (the return value of the last expression in the block).
The return value is then evaluated by `select` for _truthiness_. If the return value is "truthy", the element in that iteration will be selected. If it is "falsey", it will not.
When an element is selected, it is placed in a _new collection_. `select` returns _the new collection_ containing all of the selected elements.

## `map`

Ruby also has a built in method for performing transformation on collections. Like `select`, the `map` method evaluates the return value of the block, but uses it for transformation rather than selection:

```ruby
[1, 2, 3].map do |num|
  num * 2
end
```

In the above example, `map` takes the return value of the block (the product of `num * 2`) and places it in a _new collection_. Like `select`, `map` returns that _new collection_.

## Enumerable

The methods described above are built-in Ruby methods. It is important to note that not all methods are available to all different types of object.
`Array` and `Hash` each have an `each` method specific to that class, with different definitions of how those collections are iterated over.
The `select` and `map` methods are defined in a module called **Enumerable**. This module is available to both the `Array` and `Hash` classes.
This will be covered in more depth later, but for now just know that certain collection types have access to specific methods for a reason.
For example, `String` doesn't have access to the methods in the `Enumerable` module, so we can't call `select` or `map` directly on a string (you'd need to convert it to an array first).

## Summary

The above methods allow for simpler implementations of common tasks performed on collections, and are preferred over manually looping.

Here is a helpful summary for reference:

Method: `each`
Action: Iteration
Considers return value of block? No
Returns a new collection? No
Length of the returned collection: length of original

---

Method: `select`
Action: Selection
Considers return value of block? Yes (its truthiness)
Returns a new collection? Yes
Length of the returned collection: length of original or shorter

---

Method: `map`
Action: Transformation
Considers return value of block? Yes
Returns a new collection? Yes
Length of the returned collection: length of original
