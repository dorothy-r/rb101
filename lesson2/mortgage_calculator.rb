# Build a mortgage calculator

# Problem:
# Input: The loan amount (string, convert to float)
#        The Annual Percentage Rate (string, convert to float/100)
#        The loan duration in years (string, convert to float)
# Output: The monthly payment (float)

# Examples:
# Input: Loan amount: 100_000
#        APR: 6
#        Loan duration: 10
# Output: Monthly payment: 1110.21
# Input: Loan amount: 350_000
#        APR: 3
#        Loan duration: 30
# Output: Monthly payment: 1475.61

# Data Structures:
# No collections needed. Mostly just doing arithmetic.
# Important to convert inputs to the values needed in the formula (monthly rate, etc)

# Algorithm
# Ask user to input loan amount, duration, and APR
# Convert all input to floats, and convert APR to a decimal.
# Calculate the monthly interest rate and the loan duration in months.
# Calculate the monthly payment
# Display the monthly patment to the user

def get_monthly_interest(annual)
  (annual / 100) / 12
end

def get_duration_months(years)
  years * 12
end


puts "Welcome to the mortgage calculator!
Simply input the amount, duration and APR of your loan to determine your monthly payment."

puts "\nWhat is the loan amount?"
principal = gets.chomp.to_f

puts "What is the loan duration, in years?"
years_duration = gets.chomp.to_f

puts "What is the APR? (enter 5 for 5%, 2.5 for 2.5%, etc)"
apr = gets.chomp.to_f

monthly_rate = get_monthly_interest(apr)
months_duration = get_duration_months(years_duration)

monthly_payment = principal * (monthly_rate / (1 - (1 + monthly_rate)**(-months_duration)))

puts "Your monthly payment is: $#{monthly_payment.round(2)}"