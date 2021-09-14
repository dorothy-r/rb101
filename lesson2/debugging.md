# Debugging

(Lesson 2 Topic 13)
Most of the day-to-day life of a programmer is spent working out problems.

## Temperament

Having a patient and logical temperament is the key to debugging. And debugging is the key to programming.
Developers need to develop a systematic, patient temperament when dealing with frustrations.

## Reading Error Messages

It is critical to be able to read and understand the **stack trace** when you run into an error.
Learn to find the meaningful, relevant parts (i.e. the error message).

## Online Resources

1. Search Engine
   It can be helpful to use a search enging to look up the error message. Try prefacing your search with "Ruby" to make sure the results are relevant.
2. Stack Overflow
   This site has answers to many common problems.
3. Documentation
   Make sure you are looking at the official documentation for Ruby, and not a library or framework.

## Steps to Debugging

1. Reproduce the Error
   Find a deterministic way to consistently reproduce the problem. Then begin to isolate the root cause.
2. Determine the Boundaries of the Error
   Tweak the data that caused the error. Modifying the data or code can provide an idea of the scope of the error and the boundaries of the problem. This allows for a deeper understanding of the problem, and thus a better solution.
3. Trace the Code
   Trace the code backwards to figure out which method or part of the program the bug originates from. This is called _trapping the error_.
4. Understand the Problem Well
   Once you've identified the source of the bug, break down the code within that part of the program to find the specific error causing the bug.
5. Implement a Fix
   There are often multiple ways to make a fix. It is important to only fix _one problem at a time_.
6. Test the Fix
   Make sure that the changes fixed the problem by using tests similar to those in step 2. (Eventually, you will do this with automated testing.)

## Techniques for Debugging

1. Line by Line
   Most bugs are a result of overlooking a detail. Carefully reading code line-by-line helps uncover these mistakes.
2. Rubber Duck
   Explaining the problem to an object, like a rubber duck, helps you to focus your mind and walk through the code in detail. This may reveal the source of the problem.
3. Walking Away
   Taking a break to walk, jog, shower, or even sleep can shift your focus, while your brain continues to work on the problem in the background. This only works if you have spent time working on the problem and loading it into your brain.
4. Using Pry
   Pry is a Ruby REPL. Use it in a program by adding `require "pry"`. Once you've done this, you can insert `binding.pry` anywhere in the code. When Ruby gets to that line, execution stops and you can inspect the state of the program at that point. (It gives a prompt where you can type in an expression or variable and see what its return value is at that point. Press `Ctrl + D` to continue executing the program of type `exit-program` to quit.)
5. Using a Debugger
   Pry can also be used as a debugger program, with a mechanism to step into functions and more systematically walk over code. We'll learn this later.
