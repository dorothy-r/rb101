# Selection and Transformation

After iteration, the two most common actions to perform on a collection are _selection_ and _transformation_.
These 3 actions allow us to manipulate a collection nearly any way we need to.
Selection is choosing certain elements from the collection depending on some criterion.
Transformation is manipulating every element in the collection.
Given `n` elements in an array, selection results in `n` or fewer elements, and transformation always results in exactly `n` elements.
Both of these actions use the basic mechanics of looping: a loop, a counter, a way to get the current value, and a way to exit the loop. Additionally, they require some criteria: either to determine which elements are selected or to determine how to do the transformation.

## Looping to Select and Transform

Here is an example of selection, involving the selection of a single character from a string. This is just a basic loop with an `if` statement inside of it:

```ruby
alphabet = 'abcdefghijklmnopqrstuvwxyz'
selected_chars = ''
counter = 0

loop do
  current_char = alphabet[counter]

  if current_char == 'g'
    selected_chars << current_char
  end

  counter += 1
  break if counter == alphabet.size
end

selected_chars
```

The `if` condition is the selection criterion: it determines which values are selected.

Here is an example of transformation, involving appending an `s` to each string in the array:

```ruby
fruits = ['apple', 'banana', 'pear']
transformed_elements = []
counter = 0

loop do
  current_element = fruits[counter]

  transformed_elements << current_element + 's'

  counter += 1
  break if counter == fruits.size
end

transformed_elements
```

There is not `if` condition, since every element is being transformed. The transformation criteria is the entire line where elements are pushed to the `transformed_elements` array.
This example returns a new array, leaving the original unchanged. In transformations, it is important to pay attention to whether the original collection was mutated or a new collection returned!

## Extracting to Methods

It is often useful to extract specific selection and transformation actions to convenience methods.
For example, this `select_vowels` method could be used on any string:

```ruby
def select_vowels(str)
  selected_chars = ''
  counter = 0

  loop do
    current_char = str[counter]

    if 'aeiouAEIOU'.include?(current_char)
      selected_chars << current_char
    end

    counter += 1
    break if counter == str.size
  end

  selected_chars
end
```

Note that this method returns a _new_ string. Therefore, we can call other methods on that return value:

```ruby
number_of_vowels = select_vowels('hello world').size
number_of_vowels # => 3
```

How would you implement a method to select from this hash the key-value pairs where the value is 'Fruit'?

```ruby
produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(food_hash)
  keys = food_hash.keys
  counter = 0
  selected_items = {}

  loop do
    break if counter == keys.size  # at the top in case hash is empty

    current_key = keys[counter]
    current_value = food_hash[current_key]

    if current_value == 'Fruit'
      selected_items[current_key] = current_value
    end

    counter += 1
  end

  selected_items
end

select_fruit(produce) # => {"apple" => "Fruit", "pear"=>"Fruit}
```

Here is an example of a method that transforms an array, multiplying each element by 2:

```ruby
def double_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    doubled_numbers << current_number * 2

    counter += 1
  end

  doubled_numbers
end
```

This method returns a new array, and the original is unchanged.
Can you implement a `double_numbers!` method that mutates its argument?

```ruby
def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    numbers[counter] *= 2

    counter += 1
  end
  numbers
end
```

Next, this is an example of a method that only transforms a subset of the elements in a collection, only multiplying them by 2 if the value is odd:

```ruby
def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *=2 if current_number.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end
```

Again, this method does not mutate its argument; it returns a new array.

Try coding a method that doubles the numbers that have odd indices:

```ruby
def double_odd_indices(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *=2 if counter.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end
```

## More Flexible Methods

The above examples took one argument (the collection being transformed/selected from) and performed one operation.
It is possible to create more flexible, generic methods, though, if we define our methods to allow additional arguments that alter the logic of the iteration.
Here is a more generic version of our `select_fruit` method that allows us to specify which value we want to select:

```ruby
def general_select(produce_list, selection_criteria)
  produce_keys = produce_list.keys
  counter = 0
  selected_produce = {}

  loop do
    break if counter == produce_keys.size

    current_key = produce_keys[counter]
    current_value = produce_list[current_key]

    if current_value == selection_criteria  # used to be 'Fruit'
      selected_produce[current_key] = current_value
    end

    counter += 1
  end

  selected_produce
end
```

By passing in a hash and selection criteria, we can select for 'Vegetable' or 'Meat' or any other criteria, not just 'Fruit'.

Now try updating the `double_numbers` method to allow us to multiply the values in an array by any number.

```ruby
def multiply(numbers, factor)
  multiplied_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    multiplied_numbers << current_number * factor

    counter += 1
  end

  multiplied_numbers
end
```

Here is one more example, making our earlier letter selection loop into a more generic method, `select_letter`, that returns a new string containing only the occurrences of the letter specified:

```ruby
def select_letter(sentence, character)
  selected_chars = ''
  counter = 0

  loop do
    break if counter == sentence.size
    current_char = sentence[counter]

    if current_char == character
      selected_chars << current_char
    end

    counter += 1
  end

  selected_chars
end
```

This method returns a string, so we could chain string methods on the return value: `select_letter(sentence, 'a').size` (to find out how many times a letter occurs in a sentence, for example)

_note on the `for` loop_
So far, we have been using the `Kernel#loop` method to illustrate looping over a collection, though it is only one of many different ways to loop in Ruby. For example, the `for` loop can be used to get the same results:

```ruby
alphabet = 'abcdefghijklmnopqrstuvwxyz'

for char in alphabet.chars
  puts char
end
```

In this example, `char` represents the value of the current element in the array.
LS will mostly use `loop`, for consistency. But its important to know that the underlying concepts reamin, even when another syntax is used.
