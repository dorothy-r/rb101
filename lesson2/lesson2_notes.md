# Lesson 2 Notes

## Truthiness

In Ruby, booleans are represented by the `true` and `false` objects. They have real classes behind them (TrueClass and FalseClass), and you can call methods on them.

### Logical Operators

`&&` returns `true` only if both expressions evaluate to true.
You can chain multiple expressions with `&&`, and the chain will be evaluated left to right. If any of the expressions is false, the entire chain is false.
`||` returns `true` if either of the expressions evaluates to true.
Can chain multiple expressions with `||` as well. The chain will only return `false` if all expressions are false.
Both `&&` and `||` operators _short circuit_, that is they stop evaluating expressions once the return value is guaranteed.
So, `&&` will short circuit (and return `false`) when it encounters the first false expression.
And `||` will short circuit (and return `true`) when it encounters the first true expression.

### Truthiness vs `true`

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

## Pseudo-Code

Pseudo-code is meant for humans to read. It's helpful to spend time writing pseudo-code before going to programming code, since it helps to load the problem into your brain and make sure you understand it well.
Writing a solution in pseudo-code first helps to separate the logical problem domain layer from the syntactical programming language layer.

### Formal Pseudo-Code

Some common pseudo-code keywords that help break the logic into concrete commands, making the translation to program code easier:
START: start of the program
SET: sets a variable
GET: retrieves input from user
PRINT: displays output to user
READ: retrieves value from variable
IF/ELSE IF/ELSE: shows conditional branches in logic
WHILE: shows looping logic
SUBPROCESS: notes that another method/function/process will handle something. Helps make pseudo-code for a larger program clearer.
END: end of the program

### Going from Pseudo-Code to Code

The first pass at the code is to ensure that the logic works. Once you verify that it does, you can start to improve the code at the language level.
In larger, more sophisticated problems, you need to take a piecemeal approach to this, tackling one part of the program at a time.

## Flowcharts

Flowcharts help map out the logical sequence of a program visually.
Use these shapes:
Oval: Start/Stop
Rectangle: Processing Step
Parallelogram: Input/Output
Diamond: Decision
Circle: Connector
They can help with mapping out the step-by-step logic (the _procedural_ way of solving a problem).
In higher-level languages like Ruby, basic concepts are encapsulated in methods; using those is the _declarative_ way of solving a problem. Flowcharts looking at a high level view of a large program can use declarative syntax.
Then the subprocesses can be mapped out in more detail in a separate flowchart.

## Rubocop

Refer to Topic 10 for any questions/issues with this!
