=begin
To drive that last one home... let's turn the tables and have the string show a
modified output, while the array thwarts the method's efforts to modify the
caller's version of it.
=end

def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array =["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}" # "pumpkinsrutabaga"
puts "My array looks like this now: #{my_array}" # ["pumpkins"]

=begin
In this case, a mutating method--String#<<--has been called on `a_string_param`.
So this method-scoped variable continues to point to the same object as `my_string`.
On the other hand, `an_array_param` has been reassigned and points to a new object,
and the object assigned to my_array remains unchanged.
=end