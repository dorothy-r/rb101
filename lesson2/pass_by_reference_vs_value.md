# Pass by Reference vs Pass by Value

Rubyists disagree on which one Ruby is. The discussion refers to what happens to objects when they are passed into methods: they can either be "references" to the original object, or "values" (copies of the original).

## Pass by value

In C, when you "pass by value", the method has a _copy_ of the original object. Any operations performed on it within in the method have no effect on the original object out side of the method.

Some people say Ruby is "pass by value" because re-assigning an object within a method doesn't affect the object outside the method.

## Pass by reference

However, there are ways that Ruby allows operations within a method to change the original object, for example:

```
def cap(str)
  str.capitalize!
end
```

This would imply that Ruby is "pass by reference", since operations within a method can affect the orignal object. However, not _all_ operations affect the original.

## What Ruby does

Ruby demonstrates a combination of behaviors from both "pass by reference" and "pass by value".
Basically, **when an operation within the method mutates the caller, it will affect the original object.**
You will learn through experience which methods mutate the caller. (In the Ruby standard library, many of these destructive methods end with a `!`)
Re-assignment is not a destructive operation.

## Variables as Pointers

The above behavior can be explained by understanding how Ruby treats variables: they act as pointers to an address space in memory.
The variable doesn't contain the value; it contains a pointer to a specific area in memory that contains the value.
Operations that mutate the caller change the existing address space, while the variables continue to point to it.
Reassigning a variable makes the variable point to a different address space.

## Variable References and Mutability of Ruby Objects

An object is a piece of data that has some sort of state (or value) and associated behavior. It can be simple, like a Boolean object, or complex, like an object representing a database connection.
Objects can be assigned to variables. In this example, Ruby will associate the variable `greeting` with the String object whose value is 'Hello':

```
greeting = 'Hello'
```

You can also say the variable is _bound_ to the String object, or the String objects is assigned to the variable.
The variable `greeting` references the String object by storing the object id of the String. (You can find a Ruby object's unique object id by calling `#object_id` on it.)

What happens when you assign `greeting` to a new variable?

```
whazzup = greeting
```

`whazzup` and `greeting` now have the same object id. This shows that they are references to the same String object (not two different objects that happen to have the same value).
Since both variables are associated with the same object, if we use one variable to mutate the object, the changes will be shown when we use the other variable as well. This is because the object itself has changed, and both variables still reference it.

### Reassignment

What happens if we reassign one of the variables?

```
greeting = 'Dude!'
```

Now, `greeting` and `whazzup` refer to different objects; they have different values and different object ids.
Reassignment to a variable does not mutate the object it referenced. Instead, it binds the variable to a different object. The original object is disconnected from the variable.

### Mutability

Objects can be either mutable or immutable. Mutable objects' values can be altered; immutable objects cannot be mutated--only reassigned.
In Ruby, numbers and boolean values are immutable. Once created, they cannot be changed--only reassigned.
There are no methods available that let you mutate the value of any immutable object.
Reassignment (including `+=`, `-=`, and other assignment operators) does not mutate an object. It creates a new object and binds the variable to it.
In addition to numbers and booleans, objects of some complex classes, such as `nil`, and Range objects (`1..10`) are immutable. Any class can be immutable if it doesn't provide methods that alter its state.

Most objects in Ruby _are_ mutable: they are objects of a class that permits changes to the object's state.
Mutation can be performed by setter methods (or setters), a method defined by a Ruby object that allows a programmer to explicitly change the value of part of an object. For example, the `Array#[]=` method:

```
a = [1, 2, 3, 4, 5]
a[3] = 0
a  # => [1, 2, 3, 0, 5]
```

Although `a` was altered, its object id remained the same. The variable `a` is still referring to the same object; the object itself was mutated.
The object id of a[3] _does_ change. a[3] was bound to a new Integer object. We mutated the Array object by assigning a new value to the element at index 3.
Collection classes all behave in a similar way: a variable references the collection, and the collection contains references to the actual objects in the collection.
Strings are a bit different, but act in a similar way.
Several String, Array, and Hash methods mutate the original object.

### A Brief Introduction to Object Passing

When you pass an object as an argument to a method, the method can (in theory) either mutate the object or leave it unchanged.
A method's ability to mutate an argument depends not only on the mutability of the object represented by the argument, but also on how the argument is passed to the method.
Some languages make copies of method arguments, so the original objects can't be mutated (pass by value).
Others pass references to the original objects into the method (pass by reference). These can be used to mutate the original object, if it is mutable.
Many languages use both strategies.

#### Mental model for object passing in Ruby

Since immutable objects can't be changed, they act like Ruby passes them by value.

```
def increment(a)
  a = a + 1
end

b = 3
increment(b)  # => 4
b # => 3
```

On the other hand, mutable objects can always be mutated simply by calling one of their mutating methods. They act like Ruby passes them by reference.

```
def append(s)
  s << '*'
end

t = 'abc'
append(t) # => 'abc*'
t # => 'abc*'
```

This isn't completely accurate, but it helps to understand how the code works.

## Mutating and Non-Mutating Methods in Ruby

Methods can be either mutating or non-mutating. Mutating methods change the value (or state) of an object; non-mutating methods do not.
Important to be specific about the object that may or may not be mutated by a particular method. For example, `String#sub!` mutates the String object used to call it, but does not mutate its arguments.

### Non-Mutating Methods

A method is non-mutating with respect to an argument or its calling object if it does not mutate the given object.
Most methods do not mutate either their arguments or their caller. Some do mutate the caller; few mutate the arguments.
All methods are non-mutating with respect to immutable objects. So any method that operates on numbers or booleans is guaranteed to be non-mutating.

#### Assignment is Non-Mutating

Assignment does not mutate an object; it connects the variable to a new object. `=` is not a method in Ruby, but it acts like a non-mutating method and can be treated as such.
Assignment always binds the target variable on the left hand side of the `=` to the object referenced by the right hand side.
The object originally referenced by the target variable is never mutated.
Any mutating operations _prior_ to the assignment may still take place:

```
def fix(value)
  value << 'xyz'
  value = value.upcase
  value.concat('!')
end
s = 'hello'
t = fix(s)
s # => 'helloxyz'
t # => 'HELLOXYZ!'
```

We are not mutating when using `+=` or other assignment operators.

```
s = 'Hello'
s += ' World'
```

The second line above creates a new String object, then binds `s` to it.

Setter methods for class instance variables and indexed assignment are _not_ the same as assignment. They usually do mutate the calling object.

### Mutating Methods

A method is mutating with respect to an argument or its caller if it mutates its value in the process.
Many methods that mutate their caller use `!` as the last character of their name. (This is not always true, though. For example, String#concat mutates the caller but does not include a `!`)

#### Indexed Assignment is Mutating

This is used by String, Hash, and Array objects:

```
str[3] = 'x'
array[5] = Person.new
hash[:age] = 25
```

This is confusing because it looks exactly like assignment, which is non-mutating. But `#[]` mutates the original object. It does not change the binding of the variable.
Indexed assignment is a method that a class must supply if it needs it. The method is named `#[]=` and it mutates the object to which it applies.
Indexed assignment does cause a new reference to be made, but it is the collection element(e.g. `array[5]`) that is bound to the new object, not the collection itself.

#### Concatenation is Mutating

The `#<<` method used by collections and the String class implements concatenation. Unlike `+=`, it _is_ mutating.

```
s = 'Hello'
s << ' World'
```

The object referenced by `s` is mutated here; no new objects are created.

#### Setters are Mutating

Setters are similar to indexed assignment; they are defined to mutate the state of an object, but they superficially look like assignments.
With setters, the state of the object is altered, usually by mutating or reassigning an instance variable.

## Object Passing in Ruby -- By Reference or by Value?

Ruby appears to use pass by value for immutable objects, and pass by reference for mutable objects.

### What is Object Passing?

In Ruby, almost everything is an object. When you call a method with some expression as an argument, Ruby reduces it to an object and makes it available inside the method.
This process is called passing the object to the method, or object passing.
The caller of a method--the object on which the method is called--can also be considered an implied argument.
Return values are objects that methods pass back to the caller.
In Ruby, we can also pass objects to and from blocks, procs, and lambdas.
In Ruby, many operators (like +, \*, [], !) are methods, too.

### Evaluation Strategies

Every programming language uses some sort of evaluation strategy when passing objects.
Ruby exclusively uses _strict evaluation_, meaning that every expression is evaluated and converted to an object before it is passed along to a method.
The two most common strict evaluation strategies are pass by value and pass by reference.

#### Why is the Object Passing Strategy Important?

Most computer languages that use strict evaluation default to pass by value, but make it possible to pass by reference when needed. Few use solely one or the other.
Understanding which strategy is used when is key to understanding what happens to an object that gets passed to a method.

#### Pass by Value

With pass by value, a copy of an object is created, and that copy gets passed around. It is impossible to change the original object; any changes made in the method just changes the copy and leaves the original unchanged.
Passing immutable values in Ruby acts a lot like pass by value.

#### Pass by Reference

With pass by reference, a reference to an object is passed around. Both the argument and the original object refer to the same location in memory. If you mutate the argument, you also mutate the original object.
Ruby appears to use pass by reference when passing mutable objects.

### It's References All the Way Down

Remember that in Ruby, variables don't contain objects; they are references to objects.
So given this, how is it that passing immutable objects acts like pass by value? What exactly is happening?
Look at this example:

```
def print_id number
  puts "In method object id = #{number.object_id}"
end
value = 33
puts "Outside method object id = #{value.object_id}"
print_id value
```

The output is:

```
Outside method object id = 67
In method object id = 67
```

So `number` and `value` are referencing the same (immutable) object. It appears that Ruby is using pass by referenc.
This changes our mental model! Note that pass by reference isn't limited to mutating methods. Passing a reference doesn't guarantee that the object can be mutated.

### Pass by Reference Value

It is not wrong to say that Ruby is pass by reference.
However, the issue of assignment complicates things.
In a pure pass by reference language, assignment would be a mutating operation; in Ruby, it isn't.
In Ruby, a variable contains a pointer to an object. Assignment changes that pointer, causing the variable to be bound to a different object.
Inside of a method, we can change which object is bound to a variable, but not the binding of the original arguments. The objects can be changed, if they are mutable, but the references themselves are immutable.
This sounds more like pass by value! Ruby appears to be making copies of the references, then passing those copies to the method. Those references can be used to mutate the referenced object, but since the reference itself is a copy, the original reference given cannot be reassigned.
Therefore, it's not uncommon to say that Ruby is _pass by reference value_ or _pass by value of the reference_. Ruby passes around copies of the references.
It is neither pass by value nor pass by reference, but employs a third strategy that blends the two.

## Final Mental Model

What object passing strategy does Ruby use?

- Pass by reference value is probably the most accurate answer. But its not always helpful when trying to understand whether a method will mutate an argument.
- Pass by reference is also accurate, as long as you account for assignment and immutability.
- It is also reasonable to think of Ruby as acting like pass by value for immutable objects and pass by reference for mutable objects, as long as you remember that Ruby only _appears_ to behave like this.
