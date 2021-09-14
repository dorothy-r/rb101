# Truthiness

In Ruby, booleans are represented by the `true` and `false` objects. They have real classes behind them (TrueClass and FalseClass), and you can call methods on them.

## Logical Operators

`&&` returns `true` only if both expressions evaluate to true.
You can chain multiple expressions with `&&`, and the chain will be evaluated left to right. If any of the expressions is false, the entire chain is false.
`||` returns `true` if either of the expressions evaluates to true.
Can chain multiple expressions with `||` as well. The chain will only return `false` if all expressions are false.
Both `&&` and `||` operators _short circuit_, that is they stop evaluating expressions once the return value is guaranteed.
So, `&&` will short circuit (and return `false`) when it encounters the first false expression.
And `||` will short circuit (and return `true`) when it encounters the first true expression.

## Truthiness vs `true`

Ruby considers more than just the `true` object to be truthy.
In Ruby, _everything_ is truthy, except _`false`_ and _`nil`_.
This means anything that doesn't evaluate to `false` or `nil` is considered true when working with a conditional, or with logical operators. But it is not equal to the `true` object. For example:

```
num = 5

if num  # this is 'truthy'
  puts "valid number"
else
  puts "error!"
end

num == true  # => false
```

## Some Notes on the Calculator Program

Some things to note:

String#to_f and String#to_i do not return an exception even if there is not a valid number at the start of the string:

```
'Hello'.to_f # => 0.0

'Hello'.to_i # => 0
```

Local variables intialized within an if can be accessed outside of the if statement.

In Ruby, `if` expressions can return a value.
