=begin
Let's look at object id's again from the perspective of a method call instead
of a block.
Here we haven't changed ANY of the code outside or inside of the block?method.
We simply took the contents of the block from the previous practice problem and
moved it to a method, to which we are passing all of our outer variables.
Predict how the values and object ids will change throughout the flow of the code below:
=end

def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id #85
  b_outer_id = b_outer.object_id #60
  c_outer_id = c_outer.object_id #80
  d_outer_id = d_outer.object_id #85

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)
  
  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the method call."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the method call."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the method call."
  puts
  # These outer ids will be the same before and after the method call. 
  # Reassignment within a method definition does not affect the outer scope variables. 
  # The parameter variables have no relationship to the outer scope variables (even though they have the same name in this example)

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts
  # The rescue clause will kick in here, since variables intialized inside a method definition are not available here.
end

def an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)
  puts "a_outer id was #{a_outer_id} before the method and is #{a_outer.object_id} inside the method." # 85
  puts "b_outer id was #{b_outer_id} before the method and is: #{b_outer.object_id} inside the method." # 60
  puts "c_outer id was #{c_outer_id} before the method and is: #{c_outer.object_id} inside the method." # 80
  puts "d_outer id was #{d_outer_id} before the method and is: #{d_outer.object_id} inside the method." # 85
  puts

  a_outer = 22 # 45
  b_outer = "thirty three" # 100
  c_outer = [44] # 120
  d_outer = c_outer[0] # 89

  puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
  puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
  puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
  puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
  puts

  a_inner = a_outer
  b_inner = b_outer
  c_inner = c_outer
  d_inner = c_inner[0]

  a_inner_id = a_inner.object_id # 45
  b_inner_id = b_inner.object_id # 100
  c_inner_id = c_inner.object_id # 120
  d_inner_id = d_inner.object_id # 89

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the method (compared to #{b_outer.object_id} for outer)."
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the method (compared to #{c_outer.object_id} for outer)."
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the method (compared to #{d_outer.object_id} for outer)."
  puts
end

fun_with_ids