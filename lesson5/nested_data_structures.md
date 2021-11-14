# Nested Data Structures

Collections often contain other collections. Here are some examples of how to
work with nested data structures.

## Referencing collection elements

Here's an example of an array that contains two separate arrays:

```ruby
arr = [[1, 3], [2]]
```

Each inner array has its own zero-based index, even though they are both inside of an array.
You can access each inner array the same way you would access any other array element:

```ruby
arr[0] # => [1, 3]
arr[1] # => [2]
```

To access an element in an inner array, first access that array, then chain a reference to the element you want to access from that array:

```ruby
arr[0][1] # => 3
arr[1][0] # => 2
```

## Updating collection elements

The Ruby method for updating array elements `[] =` permanently changes an element in an array.
We can also use it to modify values in a nested array:

```ruby
arr = [[1, 3], [2]]
arr[0][1] = 5
arr # => [[1, 5], [2]]
```

The second line of code above chains the element update method `[]=` to the element reference method `[]`.

How would we insert an additional element into an inner array?
Similar to the above actions: chain element reference(`[]`) with appending (`<<`):

```ruby
arr = [[1], [2]]
arr[0] << 3
arr # => [[1, 3], [2]]
```

## Other nested structures

Hashes can also be nested within an array (or within a hash). Here's an example of two hashes nested in an array:

```ruby
[{ a: 'ant' }, { b: 'bear' }]
```

How would we add a new key/value pair into the first hash? Again, it is a two-step process: reference the first element in the array (the hash), then update it:

```ruby
arr = [{ a: 'ant' }, {b: 'bear' }]

arr[0][:c] = 'cat'
arr # => [{ :a => "ant", :c => "cat"}, { :b => "bear" }]
```

Above, we chain element reference `[]` with the normal hash key/value creation syntax to add a new pair.

Arrays can contain any type of Ruby object. They can hold different types of objects at the same time, including nested data structures. Here is an example, as well as some ways to retrieve elements from it:

```ruby
arr = [['a', ['b']], {b: 'bear', c: 'cat' }, 'cab']

arr[0] # => ["a", ["b"]]
arr[0][1][0] # => "b"
arr[1] # => { :b => "bear", :c => "cat" }
arr[1][:b] # => "bear"
arr[1][:b][0] # => "b"
arr[2][2] # => "b"
```

## Variable reference for nested collections

It can be confusing when variables are directly referencing inner collections:

```ruby
a = [1, 3]
b = [2]
arr = [a, b]
arr # => [[1, 3], [2]]
```

The variables `a` and `b` are pointing to `Array` objects. When those variables are placed as elements in an array, it looks like we have added the actual `Array` objects they are pointing to into the array. That is true to a certain extent, but we need to consider some edge cases.
How does the addition of variable reference affect the data in nested collections? What happens if we modify `a` after placing it in `arr`?

```ruby
a = [1, 3]
b = [2]
arr = [a, b]
arr # => [[1, 3], [2]]

a[1] = 5
arr # => [[1, 5], [2]]
```

In the example above, the value of `arr` changed because `a` still points to the _same Array object_ that is in `arr`. `a[1] = 5` modified that Array object, so `arr` now references the modified object, just as `a` does.
What if we modify the first array in `arr`? Is that different than modifying `a` directly?

```ruby
arr[0][1] = 8
arr # => [[1, 8], [2]]
a # => [1, 8]
```

It produces the same result as modifying `a`. In both cases, the _Array object_ itself is being modified. Both `a` and `arr[0]` point to that object, and we can reference/modify it through either variable.

## Shallow Copy

Sometimes you will want to copy an entire collection, usually if you want to save the original collection before modifying it in some way.
Ruby has two methods that let us do this: `dup` and `clone`. Both of these methods create a _shallow copy_ of an object.
In a shallow copy, only the object that the method is called on is copied. If it contains other objects, those objects will be _shared_ not _copied_. This has a major impact on nested collections.
Both `dup` and `clone` allow objects within the copied object to be modified:

```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2[1].upcase!

arr2 # => ["a", "B", "c"]
arr1 # => ["a", "B", "c"]

arr1 = ["abc", "def"]
arr = arr1.clone
arr2[0].reverse!

arr2 # => ["cba", "def"]
arr1 # => ["cba", "def"]
```

In both of the above examples both `arr1` and `arr2` are changed. This happens because destructive String methods (`#upcase!` and `#reverse!`) were called on objects within the arrays, rather than the array itself. Because those objects are _shared_ rather than copied, mutating that object affects both collections, since both collections reference the same object.
Here are some more examples that can help clarify the difference between mutating a collection and mutating object(s) in a collection:

```ruby
# Example 1
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

arr1 # => ["a", "b", "c"]
arr2 # => ["A", "B", "C"]

# Example 2
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.each do |char|
  char.upcase!
end

arr1 # => ["A", "B", "C"]
arr2 # => ["A", "B", "C"]
```

In the first example, the destructive method `Array#map!` is called on `arr2`, which is a _copy_ of arr1. Because we modified the Array itself, not its elements, `arr1` is left unchanged.
In the second example, the destructive method `String#upcase!` is called on each element of `arr2`. Because these elements are not copies of the elements in `arr1`, but are shared with `arr1`, every element in `arr2` is a reference to the _same object_ referenced by the corresponding element in `arr1`. Therefore, when `upcase!` mutates the elements in `arr2`, `arr1` is also affected.
It is important to be aware of _exactly_ what level you are working at, especially when working with nested collections and using variables as pointers: Are you working at the level of an outer array or hash, or at the level of an object within it?

## Freezing Objects

The main difference between `dup` and `clone` is that `clone` preserves the frozen state of the object, and `dup` doesn't:

```ruby
arr1 = ["a", "b", "c"].freeze
arr2 = arr1.clone
arr2 << "d"  # => RuntimeError: can't modify frozen Array

arr3 = arr1.dup
arr3 << "d"

arr3 # => ["a", "b", "c", "d"]
arr1 # => ["a", "b", "c"]
```

What is freezing? In Ruby, mutable objects can be frozen in order to prevent them from being modified. (Integers and other immutable objects are already frozen). The `frozen?` method checks to see if an object is frozen.
It's important to note that `freeze` only freezes the object it is called on. If the object contains other objects, those will not be frozen. For example, the objects within an array can still be modified after calling `freeze` on the array.

## Deep Copy

In Ruby, there is no built-in or easy way to create a deep copy of or deep freeze objects within objects. So it is very important to be aware of exactly how `freeze`, `dup`, and `clone` work and the side effects they have, especially when working with nested collections. Remember to be aware of the level within the collection at which you are working!
