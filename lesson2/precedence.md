# Operator Precedence

Operator precedence is the set of rules that dictate how Ruby determines what **operands** each operator takes.

(Most operators have two operands; however there are unary operators: !true And ternary operators: value ? 1 : 2)
In an expression, operators with higher precedence are prioritized over those with lower precedence.
Parentheses override the default evaluation order, and can be thought of as having the highest possible precedence.
Don't rely too much on precedence: if an expression has 2 or more different operators, use parentheses to explicitly define the meaning.

## Evaluation Order

Determining which evaluations get evaluated first involves more than just operator precedence. You also need to consider left-to-right evaluation, right-to-left evaluation, short-circuiting, and ternary expressions.
In an arithmetic expression, Ruby first goes through it left-to-right and evaluates everything it can without calling any operators (e.g. method invocations).
After it has those values, it considers precedence and evaluates the result.

Right-to-left evaluation occurs with multiple assignments or multiple modifiers. These are both bad practice in Ruby, though.

The ternary operator (`?:`) and the short-circuit operators `&&` and `||` can be sources of unexpected behavior around precedence.
For example, in all 3 of these cases, 1 / 0 is never evaluated:

```
nil ? 1 / 0 : 1 + 2
nil && 1 / 0
5 || 1 / 0
```

In the first example, because the value to the left of `?` is falsy, the code to right of the `:` is the only expression evaluated.
In the other two expressions, short-circuiting means that the expression returns the value before evaluating 1 / 0.
Ruby treats these three operators differently from all others, and doesn't evaluate subexpressions unless necessary.

## Diving Deeper

Here's a case to look at in more detail:

```
array.map { |num| num + 1 }  # => [2, 3, 4]

p array.map  { |num| num + 1 }  # outputs [2, 3, 4]
```

Here, the return value of `map` gets passed into `p` as an argument, which outputs [2, 3, 4].
Here's what happens when we use `map` with a `do...end` block instead of `{}`:

```
array.map do |num|
  num + 1
end                 # => [2, 3, 4]

p array.map do |num|
  num + 1           # outputs #<Enumerator: [1, 2, 3]:map>
end                 # => #<Enumerator: [1, 2, 3]:map>
```

This happens because blocks have the lowest precedence of all operators, but `{}` has slightly higher precedence than `do...end`.
Because `do...end` is the "weakest" of all the operators, `array.map` gets bound to `p`, which invokes `array.map`, returning an Enumerator object. The Enumerator and the block are then passed to `p`. `p` prints the Enumerator and does nothing with the block.
On the other hand, because `{}` has higher priority, it binds more tightly to array.map. So array.map is called with the block in this case, and its return value gets passed to `p`.

## Ruby's `tap` method

The Object instance method `tap` passes the calling object into a block, then returns that object:

```
mapped_array = array.map { |num| num + 1 }

mapped_array.tap { |value| p value}
```

This is a useful debugging tool. It takes the calling object and passes it to the block argument, then returns the same object. Typically used to do something like print the object inside the block. This can be used to debug intermediate objects in method chains:

```
(1..10)                 .tap { |x| p x }  # 1..10
.to_a                   .tap { |x| p x }  # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
.select { |x| x.even? } .tap { |x| p x }  # [2, 4, 6, 8, 10]
.map { |x| x*x }        .tap { |x| p x }  # [4, 16, 36, 64, 100]
```

## Remember to Use Parentheses!

Don't rely on precedence rules when mixing operators. Relying on memory for these makes it too easy to introduce a bug.
