# Modify the method below so that it prints the current number and stops
# iterating when the current number equals 2.

5.times do |index|
  puts index
  break if index == 2
end