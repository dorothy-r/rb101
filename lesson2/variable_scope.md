# Variable Scope

(This is referring to local variables.)

A variable's scope is defined by where the variable is initialized.

## Variables and Blocks

In this example, the _block_ is the code follwoing the method invocation (`each`):

```
[1, 2, 3].each do |num|
  puts num
end
```

Can also be written like:

```
[1, 2, 3].each { |num| puts num }
```

The block is an argument being passed into the method.

Blocks create a _new scope_ for local variables. You can think of this as _inner scope_. Nested blocks create nested scopes.
**Variables initialized in an outer scope can be accessed in an inner scope, but not vice versa.**
You can _change_ outer scope variables from an inner scope, and that change will affect the outer scope.
_note_: When instantiating variables in an inner scope, make sure that you are not accidentally re-assigning an existing outer scope variable!
Peer blocks (blocks at the same level within the program) also cannot reference variables initialized in other blocks.

### Variable shadowing

This happens when a block parameter has the same name as a variable in the outer scope. It prevents access to the outer scope local variable. For example:

```
n = 10

[1, 2, 3].each do |n|
  puts n
end
```

The `n` above will use the block parameter `n` and disregard the outer scoped variable. This also prevents making changes to the outer scoped variable:

```
n = 10

1.times do { |n| n = 11 }

puts n  # => 10
```

You want to avoid this!

In general, choosing descriptive, specific variable names helps to avoid strange behavior due to scoping issues.

## Variables and Method Definitions

Unlike blocks, a method cannot access variables that are initialized outside of its definition: its scope is self-contained. Methods can only access variables that are initialized inside the method.
When the method definition has parameters, the method can also access variables that are passed in as arguments assigned to the method parameters. This is the only way that "outside" variables can be accessed within methods.

What if a local variable and a method shared the same name? Ruby will search for a local variable first, and then try to find a method. If neither is found, a NameError will be thrown.
If you want to call a method in this situation, include a set of empty parentheses to let Ruby know that you are invoking a method and not referring to the variable. But it's a good idea to just choose different names.

### Blocks within Method Definitions

The rules of scope for blocks remain the same, even when working inside a method definition. So, blocks with the method have access to the variables from the rest of the method, but not vice versa.

## Constants

In procedural style programming, constants behave like global variables. They can be accessed within methods and blocks. And constants initialized in a block _can_ be accessed outside of it.
Constants have _lexical scope_.

## More details about methods, blocks, how they inter-relate, and how local variable scope fits into the picture

**Method definition** is when we define a Ruby method using the `def` keyword.

**Method invocation** is when we call a method, either an existing method from the core Library, or a custom method we've previously defined.

A block is _part of_ a method invocation. In fact, blocks are _defined_ by method invocation followed by `do..end` or curly braces.
The block essentially acts as an argument to the method.
Technically, you can pass a block to any method. However, the method will only executed the block if the `yield` keyword is part of the method definition. The `yield` keyword controls the interaction with the block.

Depending on the method definition, the method can use the block's return value to perform another action (e.g. the Array#map method). This is another way that methods can access local variables: through interactions with blocks (which can access local variables in outer scope).

Considering this additional context, think of **method definition** as setting a certain scope for any local variables via the parameters it has, what it does with those parameters, and if/how it interacts with a block.
**Method invocation** is using the scope set by the method definition. If the method is defined to use a block, then the block's scope gives the method additional flexibility in how it interacts with the rest of the program.
