# Collections Basics

Collections are objects made up of individual elements. The most commonly used collections in Ruby are `String`, `Array`, and `Hash`.

## Element Reference

### String Element Reference

Strings user an integer-based index, starting at zero, to represent each character in the string. You can reference a specific character by its index.
You can reference multiple characters by using the index of your starting character, and the number of characters to return:

```ruby
str = 'abcdefghi'
str[2] # => "c"
str[2, 3] # => "cde"
# The second example is actually an alternative syntax for `str.slice(2, 3)`. It calls the `String#slice` method.
```

We can combine the above reference methods using _method chaining_.

```ruby
str[2, 3][0] # => "c"
```

How would you reference `grass` from within this string?

```ruby
str = 'The grass is green'

str[4, 5] # => "grass"
str.slice(4, 5) # => "grass"
```

### Array Element Reference

Arrays are ordered, zero-indexed collections of elements, which can be any object. Like strings, they use an integer-based index to maintain the order of the list.
Similar to a string, you can reference a specific element by its index, and multiple elements by using `Array#slice` or its alternative syntax (`Array#[]` with 2 arguments):

```ruby
arr = ['a', 'b', 'c', 'd', 'e', 'f', 'g']

arr[2] # => "c"
arr[2, 3] # => ["c", "d", "e"]
arr[2, 3][0] # => "c"
```

One thing to note is that `Array#slice` returns a new array, and `String#slice` returns a new string (they are different methods!). The exception with `Array#slice` is if we pass the method only an index, rather than a start & length or a range. In that case, the element at the index is returned, not a new array:

```ruby
arr = [1, 'two', :three, '4']
arr.slice(3, 1) # => ["4"]
arr.slice(3..3) # => ["4"]
arr.slice(3) # => "4"
```

It is important to be aware of exactly _what_ is returned when calling methods on a collection object--it affects how you can interact with the return value.

### Hash Element Reference

Instead of an integer-based index, hashes use key-value pairs. Keys and values can be any type of Ruby object. Hash values are referenced by their keys:

```ruby
hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot' }

hsh['fruit'] # => "apple"
hsh['fruit'][0] # => "a"
```

When initializing a hash, the keys must be **unique**. Trying to reuse a key in another pair will just overwrite the original pair.
Hash values **can** be duplicated, though:

```ruby
hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot', 'fruit' => 'pear' } # This doesn't work

hsh = { 'apple' => 'fruit', 'carrot' => 'vegetable', 'pear' => 'fruit' } # This does!
```

The `Hash#keys` method returns an array of a hash's keys.
The `Hash#values` method returns an array of its values.

```ruby
country_capitals = { uk: 'London', france: 'Paris', germany: 'Berlin' }
country_capitals.keys # => [:uk, :france, :germany]
country_capitals.values # => ["London", Paris", Berlin"]
country_capitals.values[0] # => "London"
```

_note_: In Ruby, it is conventional to us use symbols as the objects for hash keys. (Symbols can be thought of as immutable strings.)

### Element Reference Gotchas

Certain issues around referencing elements can cause unexpected behavior in your code.

#### Out of Bounds Indices

Strings and arrays both use ordered indexes to reference elements. The following collections have indices from 0 to 4. What happens if you try to reference an index greater than 4?

```ruby
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[2] # => "c"
arr[2] # => "c"

str[5] # => nil
arr[5] # => nil
```

Doing this does not raise an error; it returns `nil`. This could cause issues with arrays, since `nil` could also be an element in an array:

```ruby
arr = [3, 'd', nil]
arr[2] # => nil  (This is in the array)
arr[3] # => nil  (This is an out-of-bounds index)
```

A safer way to reference array elements is by using the `Array#fetch` method. It returns the element at a given index position, and throws an error if the index is out-of-bounds. However, most Ruby code uses `#[]` instead of `#fetch`. The main thing is to be aware of what is happening and why when `#[]` returns `nil`.

#### Negative Indices

Elements in String and Array objects can be referenced using negative indices, which start counting from the last element in the collection at index `-1` and work backwards:

```ruby
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[-2] # => "d"
arr[-2] # => "d"

str[-6] # => nil
arr[-6] # => nil
```

As seen above, out-of-bounds negative indices will also return `nil`.

#### Invalid Hash Keys

Referencing invalid hash keys also returns nil. Like `Array`, `Hash` has a `#fetch` method which can help to distinguish valid hash keys with a `nil` value from invalid hash keys.

```ruby
hsh = { :a => 1, 'b' => 'two', :c => nil }

hsh['b']  # => "two"
hsh[:c]   # => nil
hsh['c']  # => nil
hsh[:d]   # => nil

hsh.fetch(:c)  # => nil
hsh.fetch('c') # => KeyError: key not found: "c"
hsh.fetch(:d)  # => KeyError: key not found: :d
```

## Conversion

Because strings and arrays are zero-indexed collections, it is fairly easy (and common practice) to convert from one to the other.
Several Ruby methods facilitate this, including `String#chars`, which returns an array of individual characters, and `Array#join`, which returns a string with the elements of the array joined together:

```ruby
str = 'Practice'

arr = str.chars # => ["P", "r", "a", "c", "t", "i", "c", "e"]
arr.join # => "Practice"
```

A hash can be converted to an array with the `Hash#to_a` method. The array returned is two-dimensional, with a sub-array for each key-value pair:

```ruby
hsh = { sky: "blue", grass: "green" }
hsh.to_a # => [[:sky, "blue"], [:grass, "green"]]
```

`Array` also has a `#to_h` method, that takes a block or converts an array of two-element arrays into a hash.

```ruby
arr = [[:name, 'Joe'], [:age, 10], [:favorite_color, 'blue']]

arr.to_h # => { name: "Joe", age: 10, favorite_color: "blue" }
```

## Element Assignment

### String Element Assignment

The element assignment notation of `String` allows us to change the value of a specific character within a string by referencing its index:

```ruby
str = "joe's favorite color is blue"
str[0] = 'J'
str # => "Joe's favorite color is blue"
```

This way of modifying a string is a _destructive_ action. In the example above, `str` is changed permanently.

### Array Element Assignment

We can similarly reassign specific elements of an array, referencing its index using `Array`'s element assignment notation:

```ruby
arr = [1, 2, 3, 4, 5]
arr[0] += 1
arr  # => [2, 2, 3, 4, 5]
```

Like modifying a string, this method is _destructive_ and permanently modifies `arr`.

### Hash Element Assignment

Hash element assignment is similar, as well, but uses a hash key to reassign a value, rather than an index:

```ruby
hsh = { apple: 'Produce', carrot: 'Produce', pear: 'Produce', broccoli: 'Produce' }
hsh[:apple] = 'Fruit'
hsh # => { :apple => "Fruit", :carrot => "Produce", :pear => "Produce", :broccoli => "Produce" }
```
