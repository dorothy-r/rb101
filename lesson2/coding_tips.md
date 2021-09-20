# LS Coding Tips

## Debugging

The hours you spend debugging are not wasted. The longer you spend figuring out a mistake, the less likely you are to make it again.
When you get "burned" by your coding mistakes, you are likely to store the issue in your long term memory.
Think about debugging from this perspective--it will help you retain knowledge!

## Naming Things

Choose descriptive names for variables and methods.
Follow Ruby conventions:
Use snake_case for everything except classes, which are CamelCase, and constants, which are UPPERCASE.
(_note_: Althought Ruby allows you to change the value of constants, they should not be mutated!)

## Methods

It is good to extract code to a method: make sure it does one thing, and that its responsibility is limited. A method should be short (no more than 10-15 lines).
Don't write a method that both displays something and returns a _meaningful_ value.
A method should either return a value with no side effects or perform side effects with no return value. The method name should reflect what it does. (No need to use 'return' in the method name, returning a value is implied.)

### Methods should be at the same level of abstraction

You should be able to extract a method from the larger program and work with it in isolation. You can use a method like this without thinking about its implementation, which helps compartmentalize focus.
Pay attention to how methods are organized, and whether you can still understand how to use your methods (without studying their implementation) after some time away.

### Method names should reflect mutation

For example, we would expect a method called `update_total` to mutate the parameter passed to it. We would not expect it to return a value.
In general, you should not have to think too much about a method, or wonder what it is doing. The naming should make its purpose clear.
Large, interesting programs are made of hundreds or thousands of small, simple methods. As your understanding of the program becomes more clear, refactor the code to reflect that.

### Method names should indicate whther a method will only display something

Prefix methods that output values directly with `print_`, `say_`, or `display_` (or similar).
These methods should not mutate parameters or return values--only output values.

## Miscellaneous Other Tips

- Don't prematurely exit the program. Your program should probably only have on exit point.
- Make sure to indent with 2 spaces, not tabs.
- Name methods from the perspective of using them later. How would you like to invoke them?
- Know when to use a "do/while" vs a "while" loop.
- Clarity over terseness
- Be very careful about "assignment within a conditional" code. You shouldn't do this on purpose, and beware of bugs caused by doing it accidentally!
