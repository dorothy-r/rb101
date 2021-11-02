=begin
Write an if/else statement that executes some code if the `process_the_loop`
variable is `true` and some other code when `process_the_loop` is false. Specifically:
- When `process_the_loop` is ture, execute a loop that iterates exactly once 
and prints "The loop was processed" during that iteration.
-When `process_the_loop` is false, just print "The loop wasn't processed!"
=end

process_the_loop = [true, false].sample

if process_the_loop
  loop do
    puts "The loop was processed"
    break
  end
else
  puts "The loop wasn't processed!"
end