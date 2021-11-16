This assignment will focus on combining the concepts covered in Lessons 4 and 5: iterating, selecting, transforming, sorting, nested collections, and using blocks.
Try to understand and analyze each example below thoroughly. The goal is to have a deep understanding of how each detail works.

**Example 1**

```ruby
[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end
# 1
# 3
# => [[1, 2], [3, 4]]
```

What's happening in this code? Try to describe every interaction with precision.

My answer:
We start with a nested array. The `each` method is called on the outer array. This method will iterate through the outer array and execute the block on each subarray.
The block calls the `first` method on each subarray to access its first element and `puts` to print it to the screen.
So the code outputs 1 and 3 (each on a separate line), and returns the original nested array (since `each` returns the original array).

LS answer:
The `Array#each` method is being called on the multi-dimesional array `[[1, 2], [3, 4]]`. Each inner array is passed to the block in turn and assigned to the local variable `arr`. The `Array#first` method is called on `arr` and returns the object at index 0 of the current array - in this case the integers 1 and 3, respectively. The puts method then outputs a string representation of the integer. `puts` returns `nil`, and since this is the last evaluated statement within the block, the return value of the block is therefore `nil`. `each` doesn't do anything with this returned value though, and since the return value of `each` is teh calling object--in this case the nested array--this is what is ultimately returned.

_notes_
When evaluating code, ask the following questions:

- What is the type of action being performed (method call, block, conditional, etc...)?
- What is the object that action is being performed on?
- What is the side-effect of that action (e.g. output or destructive action)?
- What is the return value of that action?
- Is the return value used by whatever instigated the action?

Here is a table with this information for Example 1:
| Line | Action | Object | Side Effect | Return Value | Is Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | --------------------- |
| 1 | method call (`each`) | The outer array | None | The calling object | No, but shown on line 6 |
| 1-3 | block execution | Each sub-array | None | `nil` | No |
| 2 | method call (`first`) | Each sub-array | None | Element at index 0 of sub-array | Yes, used by `puts` |
| 2 | method call (`puts`) | Element at index 0 of sub-array | Outputs string representation of an Integer | `nil` | Yes, used to determine return value of block

**Example 2**

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
end
# 1
# 3
# => [nil, nil]
```

This example is similar to the first one, but with one change: `map` is called on the outer array, not `each`. Lets look at how this changes things in a table:
| Line | Action | Object | Side Effect | Return Value | Is Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | --------------------- |
| 1 | method call (`map`) | The outer array | None | A new array `[nil, nil]` | No, but shown on line 6 |
| 1-3 | block execution | Each sub-array | None | `nil` | Yes, it is used by `map` to transform each element of the calling array |
| 2 | method call (`first`) | Each sub-array | None | Element at index 0 of sub-array | Yes, used by `puts` |
| 2 | method call (`puts`) | Element at index 0 of sub-array | Outputs string representation of an Integer | `nil` | Yes, used to determine return value of block

**Example 3**

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end
# 1
# 3
# => [1, 3]
```

Map out a detailed breakdown for the above using the same approach as the previous two examples:
| Line | Action | Object | Side Effect | Return Value | Is Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | --------------------- |
| 1 | method call (`map`) | The outer array | None | A new array `[1, 3]` | No, but shown on line 7 |
| 1-4 | block execution | Each sub-array | None | Element at index 0 of sub-array | Yes, it is used by `map` for transformation |
| 2 | method call (`first`) | Each sub-array | None | Element at index 0 of sub-array | Yes, used by `puts` |
| 2 | method call (`puts`) | Element at index 0 of sub-array | Outputs string representation of an Integer | `nil` | No
| 3 | method call (`first`) | Each sub-array | None | Element at index 0 of sub-array | Yes, to determine return value of the block

**Example 4**

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end
# 18
# 7
# 12
# => [[18, 7], [3, 12]]
```

| Line | Action                | Object                                      | Side Effect                                   | Return Value        | Is Return Value Used?                                                       |
| ---- | --------------------- | ------------------------------------------- | --------------------------------------------- | ------------------- | --------------------------------------------------------------------------- |
| 1    | variable assignment   | `[18, 7], [3, 12]]`                         | None                                          | `[18, 7], [3, 12]]` | No                                                                          |
| 1    | method call (`each`)  | The outer array                             | None                                          | The calling object  | Yes, used by variable assigmet to `my_arr`                                  |
| 1-7  | outer block execution | Each sub-array                              | None                                          | each sub-array      | No                                                                          |
| 2    | method call (`each`)  | Each sub-array                              | None                                          | The calling object  | Yes, used to determine return value of outer block                          |
| 2-6  | inner block execution | Each element within a sub-array             | None                                          | `nil`               | No                                                                          |
| 3    | comparison            | Each element within a sub-array             | None                                          | `true` or `false`   | Yes, evaluated by `if`                                                      |
| 3-5  | conditional           | The result of the comparison expression     | None                                          | `nil`               | Yes, used to determine return value of inner block                          |
| 4    | method call (`puts`)  | Each element within a sub-array that is > 5 | Outputs a string representation of an Integer | `nil`               | Yes, determines the return value of the conditional if the condition is met |

**Example 5**

```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end
# => [[2, 4], [6, 8]]
```

| Line  | Action                              | Object                               | Side Effect | Return Value                                               | Is Return Value Used?                                                       |
| ----- | ----------------------------------- | ------------------------------------ | ----------- | ---------------------------------------------------------- | --------------------------------------------------------------------------- |
| 1     | method call (`map`)                 | The outer array                      | None        | A new array `[[2, 4], [6, 8]]`                             | No, but shown on line 6                                                     |
| 1-5   | outer block execution               | Each sub-array                       | None        | A new sub-array                                            | Yes, it is used by `map` to transform each element of the calling array     |
| 2     | method call (`map`)                 | Each sub-array                       | None        | A new sub-array                                            | Yes, used to determine the return value of the outer block                  |
| 2 - 4 | inner block execution               | Each element of current sub-array    | None        | A new integer                                              | Yes, it is used by `map` to transform each element of the current sub-array |
| 3     | method call (`*` with argument `2`) | Each element of the current subarray | None        | The integer result of multiplying the current element by 2 | Yes, used to determine return value of block                                |

**Example 6**

```ruby
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]
```

In line 1, the `select` method is called on an array of hashes. This method has no side effects, and returns a new array : `[ { c: "cat" }]`
This method executes the a block covering lines 1-5. This block is executed on each hash within the array, assigned to the block variable `hash`. This block has no side effects, and it returns the boolean value returned by the inner block. This value is used by `select` to determine whether the current hash will be added to the new return array.
Within the outer block, `all?` is called on each hash. This has no side effects, and it returns a boolean value, based on the return values of the comparison `value[0] == key.to_s` in its associated inner block. If this comparison returns a truthy value for every key/value pair in the hash, `all?` will return `true` as well.
Any hash for which `all?` returns `true` will be selected by `select` for the new array that is returned.

**Example 7**
When sorting nested data structures, it is important to be clear about the level at which you are sorting and which values you are using to order the collection.

Here is an array of arrays containing numeric strings:

```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
```

Lets say we want to sort the outer array so that the inner arrays are ordered according to the numeric value of the strings they contain.
When sorting nested arrays, there are **two** sets of comparison happening:

1. Each inner array is compared with the other inner arrays.
2. The inner arrays are compared by comparing the _elements_ within them.

Since the array above is made up of strings and we want to sort them based on their numeric value, we need to perform some transformation on them before sorting them.

It is possible to carry out transformation within a `sort_by` block, like this:

```ruby
arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end
```

When we do this, the transformed elements are used to perform the comparison. Because `map` returns a new array each time it is called on a sub-array, it leaves the original sub-array unmodified. So the return value contains the original sub-arrays of strings sorted in numeric order.

**Example 8**
Using selection on a nested array is also tricky. Here is an example with a nested array, where we want to select integers greater than 13, and strings less than 6 characters. The elements that we want to select are in the inner layer of a nested data structure, so we need to access those inner arrays _before_ we can select the values we want:

```ruby
[[8, 13, 27], ['apple', 'banana', 'cantaloupe']].map do |arr|
  arr.select do |item|
    if item.to_s.to_i == item  # if it's an integer
      item > 13
    else
      item.size < 6
    end
  end
end
```

In this example, `map` allows us to iterate over the array and access the nested arrays, and also returns a new array containing the sub-arrays with their selected values.

**Example 9**
This example contains a 3-level nested array.

```ruby
[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end
# => [[[1], [2], [3], [4]], [["a"], ["b"], ["c"]]]
```

There are 3 methods involved here--each with a corresponding block. THe first method call within `map` is `each`. We know that `each` always returns the calling object, so without looking any farther, we know that the return value of `map` will be a new array that matches the value of the calling object.
In this example, there are no side effects deeper in the code, either, so that's all there is.

**Example 10**
Here is a structure of nested arrays, and an example of how to increment every number by 1 _without_ changing the data structure.

```ruby
[[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.size == 1
      el + 1
    else
      el.map do |n|
        n + 1
      end
    end
  end
end
# => [[[2, 3], [4, 5]], [6, 7]]
```

_One final note_
Do not mutate the collection that you are iterating through! Mutating a collection while you are performing selection or transformation or pretty much any other action is a bad idea. Here is an example of what not to do:

```ruby
def remove_evens!(arr)
  arr.each do |num|
    if num % 2 == 0
      arr.delete(num)
    end
  end
  arr
end

p remove_evens!([1, 1, 2, 3, 4, 6, 8, 9])
# expected return value [1, 1, 3, 9]
# actual return value [1, 1, 3, 6, 9]

# Can fix the above code by iterating through a shallow copy of the array while mutating the original:
def remove_evens!(arr)
  cloned_arr = arr.dup
  cloned_arr.each do |num|
    if num % 2 == 0
      arr.delete(num)
    end
  end
  arr
end
```
