# What is debugging?

Bugs are human errors in code.
Debugging is the process of identifying and fixing those errors.
Bugs will always be part of your life as a developer!

## Debugging Steps

- Identify the Problem
  - find the specific part of the code that is causing problems
- Understand the Problem
  - look at the context
  - test out different values/variables
  - is it a syntax error? or a logical error? (the latter usually won't throw an error)
- Implement a Solution

# Debugging Tools / pry

## What is pry?

- Pry is a Rubygem. Need to have it installed on your computer and require it in your program.
- Pry is a REPL: Read-Evaluate-Print-Loop
- It's an interactive environment that takes user input, evaluates it, returns the results, and loops back to the start

## Using pry

Can use it like irb as a REPL in terminal.

### Accessing variables and scope

pry allows us to use `cd` to change scope.
You can `cd` into an object.
Calling `ls` from there will give you information about the object and its available methods.
You can also call methods directly there, and use `show-doc [method]` to learn more about a given method.

### Invoking and debugging with pry at runtime

This is where pry really shines.

- Using binding.pry

  - A binding is something that contains references to any variables that were in scope at the point where it was created.
  - pry interrupts program execution and pries open the binding so that we can have a look around.

- whereami lets us know what line of code we are on, and the surrounding context

### Stepping through code with pry and pry-byebug

- pry-byebug extends pry with some additional commands

  - next
  - step
  - continue

- Other similar gems exist, such as pry-nav and pry-debugger
- The concept of stepping through and into code is not limited to pry or Ruby
- There are equivalents in other languages, such as Chrome Dev Tools Debugger

## Take-aways

- Debugging is an important skill to learn and practice
- Tools such as pry and pry-byebug make debugging easier
- Using these tools also helps to learn more about code
- These debugging concepts are not limited to Ruby
