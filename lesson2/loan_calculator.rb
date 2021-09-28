require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

def prompt(message, insert="")
  display = format(MESSAGES[message], var: insert)
  puts "=> #{display}"
end

def introduction
  system 'clear'
  prompt(:welcome)
  prompt(:instructions)
  puts "-------------------------------------------------------------"
end

def valid_integer?(num)
  num.to_i().to_s() == num
end

def valid_float?(num)
  '%.2f' % num.to_f() == num
end

def valid_number?(num)
  (valid_integer?(num) || valid_float?(num))
end

def positive?(num)
  num.to_f > 0
end

def get_principal
  prompt(:enter_amount)
  principal = ''
  loop do
    principal = gets.chomp
    break if valid_number?(principal) && positive?(principal)
    prompt(:valid_number)
  end
  principal
end

def get_duration_choice
  prompt(:duration_choice)
  choice = ''
  loop do
    choice = gets.chomp
    break if %w(1 2).include?(choice)
    prompt(:valid_choice)
  end
  choice
end

def get_duration(choice)
  duration = ''
  prompt(:enter_duration)
  loop do
    duration = gets.chomp
    break if valid_number?(duration) && positive?(duration)
    prompt(:valid_number)
  end
  choice == '1' ? duration : duration.to_f * 12
end

def get_apr
  prompt(:enter_apr)
  apr = ''
  loop do
    apr = gets.chomp
    break if valid_number?(apr) && (positive?(apr) || apr.to_f.zero?)
    prompt(:valid_number)
  end
  apr
end

def get_monthly_interest(annual)
  (annual / 100) / 12
end

def get_monthly_payment(amount, rate, duration)
  if rate == 0.0
    amount / duration
  else
    amount * (rate / (1 - (1 + rate)**(-duration)))
  end
end

def another_calculation?
  prompt(:go_again)
  prompt(:press_keys)
  answer = gets.chomp
  answer.downcase == 'y'
end

introduction

loop do
  principal = get_principal.to_f
  duration_choice = get_duration_choice
  months_duration = get_duration(duration_choice).to_i
  apr = get_apr.to_f
  monthly_rate = get_monthly_interest(apr)

  payment = get_monthly_payment(principal, monthly_rate, months_duration)
  prompt(:monthly_payment, '%.2f' % payment)

  break unless another_calculation?
  system 'clear'
end

prompt(:thank_you)
prompt(:good_day)
