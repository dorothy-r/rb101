1. What is the return value of the `select` method below? Why?

```ruby
[1, 2, 3].select do |num|
  num > 5
  'hi'
end
```

My answer:
The return value is `[1, 2, 3]`. The block will always return `'hi'`, since that is its final expression. Because 'hi' is truthy, `select` will select each element in the array, and return them in a new array.

LS answer:
`select` performs selection based on the _truthiness_ of the block's return value. In this case the return value will always be `'hi'`, which is a "truthy" value. Therefore `select` will return a new array containing all of the elements in the original array.

2. How does `count` treat the block's return value? How can we find out?

```ruby
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end
```

My answer:
We can find out by looking at the docs. My guess is that `count` evaluates the truthiness of the block's return value, and returns an integer representing the number of elements for which the block returns a truthy value. (And, according to the docs, I'm right!)

LS answer:
If we don't know how count treats the block's return value, then we should consult the docs for `Array#count`. Our answer is in the description:
'If a block is given, counts the number of elements for which the block returns a true value.'
Based on this information, we can conclude that count only counts an element if the block's return value evaluates as true. This means that count considers the truthiness of the block's return value.

3. What is the return value of `reject` in the following code? Why?

```ruby
[1, 2, 3].reject do |num|
  puts num
end
```

My answer:
According to the documentation, `reject` evaluates the truthiness of the block's return value, and returns a new array with the elements for which the block returns a falsy value.
This code would return the array `[1, 2, 3]`, because `puts` always returns `nil`, which evaluates to false.

LS answer:
Since `puts` always returns `nil`, you might think that no values would be selected and an empty array would be returned. The important thing to be aware of here is how `reject` treats the return value of the block. `reject` returns a new array containing items where the block's return value is "falsey". In other words, if the return value was `false` or `nil` the element would be selected.

4. What is the return value of `each_with_object` in the following code? Why?

```ruby
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
 hash[value[0]] = value
end

# => { "a" => "ant", "b" => "bear", "c" => "cat" }
```

My answer:
`each_with_object` returns the object passed as an argument to the method. The code in the block can manipulate that object. In this case, it populates the empty hash that was passed in to the method with keys that are the first character of each string in the array, and values that are the corresponding string from the array.

LS answer:
Based on our knowledge of each, it might be reasonable to think that `each_with_object` returns the original collection. That isn't the case, though. When we invoke `each_with_object`, we pass in an object (`{}` here) as an argument. That object is then passed into the block and its updated value is returned at the end of each iteration. Once `each_with_object` has iterated over the calling collection, it returns the initially given object, which now contains all of the updates.
In this code, we start with the hash object, `{}`. On the first iteration, we add `"a" => "ant"` to the hash. On the second, we add `"b" => "bear"`, and on the last iteration, we add `"c" => "cat"`. Thus, `#each_with_object` in this example returns a hash with those 3 elements.

5. What does `shift` do in the following code? How can we find out?

```ruby
hash = { a: 'ant', b: 'bear' }
hash.shift
```

My answer:
I believe that `shift` returns the first element of the collection, and also removes it from the collection. So here, `shift` returns `[:a, "ant"]` (just guessing that it will be an array with the key and value). And the new value of hash is `{ b: 'bear' }`. But we can always find out for sure in the docs! (And according to those, the above answer is correct).

LS answer:
`shift` destructively removes the first key-value pair in hash and returns it as a two-item array. If we didn't already know how `shift` worked, we could easily learn by checking the docs for `Hash#shift`. The description for this method confirms our understanding:
'Removes a key-value pair from hsh and returns it as the two-item array [ key, value ], or the hash’s default value if the hash is empty.'
There are quite a few Ruby methods, and you're not expected to know them all. That's why knowing how to read the Ruby documentation is so important. If you don't know how a method works you can always check the docs.

6. What is the return value of the following statement? Why?

```ruby
['ant', 'bear', 'caterpillar'].pop.size

# => 11
```

My answer:
`pop` removes and returns the last element of the array, in this case, `'caterpillar'`. In the code above, `size` is called on the return value of `pop`. Calling `size` on an string returns an integer representing the number of characters in the string. In this case, that number is 11.

LS answer:
There are a couple things going on here. First, pop is being called on the array. pop destructively removes the last element from the calling array and returns it. Second, size is being called on the return value by pop. Once we realize that size is evaluating the return value of pop (which is "caterpillar") then the final return value of 11 should make sense.

7. What is the **block**'s return value in the following code? How is it determined? Also, what is the return value of `any?` in this code and what does it output?

```ruby
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end
```

My answer:
The block will either return `true` or `false` depending on whether the array element on the current iteration is odd or not. In this case, it would return `true` on the first and third iterations, and `false` on the second. However, the `any?` method stops iterating after the first element for which the block returns `true`, so it doesn't actually evaluate the other elements after `1`, since that returns `true`.
The return value of `any?` in this code is `true` because the block returns `true` at least once.
It outputs `1` because it only iterates once! `puts` prints the current element to the screen on each iteration.

LS answer:
The return value of the block is determined by the return value of the last expression within the block. In this case the last statement evaluated is `num.odd?`, which returns a boolean. Therefore the block's return value will be a boolean, since `Integer#odd?` can only return `true` or `false`.
Since the `Array#any?` method returns `true` if the block ever returns a value other than `false` or `nil`, and the block returns `true` on the first iteration, we know that `any?` will return `true`. What is also interesting here is `any?` stops iterating after this point since there is no need to evaluate the remaining items in the array; therefore, `puts num` is only ever invoked for the first item in the array: `1`.

8. How does `take` work? Is it destructive? How can we find out?

```ruby
arr = [1, 2, 3, 4, 5]
arr.take(2)
```

My answer:
According to the documentation, `Array#take` takes an integer, `n`, as an argument, and returns an array of the first `n` elements of the calling object.
It also states that it does not modify the caller, so it is not destructive.

LS answer:
If you're unsure of how a method works the best thing to do is to read its documentation. Along with that, testing the method in irb can be very helpful. In this case we can quickly check if take is destructive or not by running the code in irb.

```
irb :001 > arr = [1, 2, 3, 4, 5]
irb :002 > arr.take(2)
=> [1, 2]
irb :003 > arr
=> [1, 2, 3, 4, 5]
```

By reading the docs and testing the method in irb, we're able to determine that `Array#take` selects a specified number of elements from an array. We're also able to verify that it isn't a destructive method.

9. What is the return value of `map` in the following code? Why?

```ruby
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end
```

My answer:
So I know that `map` returns a new array with the return value of the block replacing the element in the original array. The second element of the new array would then be 'bear'. I'm not sure if the first element would stay the same([[:a. 'ant']]) or be `nil`. So I will run it in irb.
And it looks like it is `nil`. Because the code following the `if` statement is not executed for the first element, the block returns `nil`. So `map`'s return value here is: `[nil, 'bear']`

LS answer:
`[nil, bear]`
There are some interesting things to point out here. First the return value of `map` is an array, which is the collection type that `map` always returns. Second, where did that `nil` come from? If we look at the `if` condition (value.size > 3), we'll notice that it evaluates as true when the length of `value` is greater than 3. In this case, the only value with a length greater than 3 is `'bear'`. This means that for the first element, `'ant'`, the condition evaluates as false and `value` isn't returned.
When none of the conditions in an `if` statement evaluates as true, the `if` statement itself returns `nil`. That's why we see `nil` as the first element in the returned array.

10. What is the return value of the following code? Why?

```ruby
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end
# => [1, nil, nil]
```

My answer:
Because `puts` returns `nil`, the block returns `nil` for all elements that are greater than one (due to the if condition), and returns the original element for all other values. In this array, only `1` returns its original value. The other two elements are printed to the screen, but the block returns `nil`, and that is what `map` returns in the new array.

LS answer:
We can determine the block's return value by looking at the return value of the last statement evaluated within the block. In this case it's a bit tricky because of the `if` statement. For the first element, the `if` condition evaluates as false, which means `num` is the block's return value for that iteration. For the rest of the elements in the array, `num > 1` evaluates as true, which means `puts num` is the last statement evaluated, which in turn means that the block's return value is `nil` for those iterations.
Therefore, the return value of `map` is:
`[1, nil, nil]`
