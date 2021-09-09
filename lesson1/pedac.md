# The PEDAC Process

PEDAC is a problem-solving process.

PEDAC stands for:

- (understand the) **Problem**
- (write) **Examples** (test cases)
- **Data Structure(s)**
- **Algorithm**
- **Code**

The first four steps are about processing the problem; only the last one is about the actual code.
PEDAC seems like a laborious process, but it actually saves time--especially for more complicated problems.
It helps prevent "hack and slash" coding.

## Step 1: Understand the Problem

Read the problem carefully. Seek a "holistic and well-rounded understanding" or what is being asked. Every word and detail in the problem statement matters.

- Identify the **inputs** and **outputs** for the problem
- Make the requirements/terms explicit. This requires understanding the problem domain, and recognizing implicit requirements (carefully reviewing any examples given can help identify these).
- Identify rules. Ask clarifying questions; don't just make assumptions.
- Come up with a mental model of the problem: a summary view of the entire problem (not _how_ to solve it, just _what_ it requires).

## Step 2: Examples/Test Cases

Come up with examples that validate your understanding of the problem, and can confirm you are working in the right direction.
The rules identified in Step 1 are a good place to find examples.
It is also important to test edge cases: e.g. Problems that involve iterating over numbers have edge cases at one or both ends of the range. Problems that work with collections often have edge cases that deal with zero, one, or many elements in the collection.

## Step 3: Data Structures

Determine which data structures you will use to conver the input to the output.
Consider the programming language and your mental model.
Note that the data structure will influence your algorithm.

## Step 4: Algorithm

Determine a seriese of instructions that will transform the input to the desired output.
If you have a mental model, start there. Otherwise, start with your intended data structure and think of how you would build and manipulate it to get the output.
Before implementing your algorithm with code, test it manually with some of your test cases to verify that it gives the expected output.

## Step 5: Code with Intent

Implement the solution in your programming language of choice.
Because of the work done in the previous steps, this simply involves translating the algorithm into the programming language syntax.
