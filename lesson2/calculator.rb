require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key, replacement = 'to_change')
message = format(messages(key, LANGUAGE), var: replacement)
  Kernel.puts("=> #{message}")
end

def get_name
  name = ''
  loop do
    name = Kernel.gets().chomp()

    if name.split == []
      prompt(:valid_name)
    else
      break
    end
  end

  name
end

def get_number
  number = ''
  loop do

    number = Kernel.gets().chomp()

    if valid_number?(number)
      number = number.to_f
      break
    else
      prompt(:valid_number)
    end
  end

  number
end

# Bonus Feature 1: Better integer validation
def valid_integer?(num)
  num.to_i().to_s() == num
end

# Float validation for Bonus Feature 2
def valid_float?(num)
  num.to_f().to_s() == num
end

# Bonus Feature 2: Number validation
def valid_number?(num)
  valid_integer?(num) || valid_float?(num)
end

def get_operator()
  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages(:valid_choice))
    end
  end
  operator
end

# Bonus Feature 3: Improve this method
def operation_to_message(op)
  message = case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            when '4'
              'Dividing'
            end
  message
end

Kernel.system("clear")

prompt(:welcome)

name = get_name()

prompt(:hello, name)
Kernel.sleep(1)

loop do
  Kernel.system("clear")
  
  prompt(messages(:first_number))
  number1 = get_number()

  prompt(messages(:second_number))
  number2 = get_number()

  prompt(messages(:operator_prompt))

  operator = get_operator()

  Kernel.system("clear")

  prompt(operation_to_message(operator) + messages(:operation)")

  result = case operator
           when '1'
             number1 + number2
           when '2'
             number1 - number2
           when '3'
             number1 * number2
           when '4'
             number1 / number2
           end

  prompt("The result is: #{result}")

  prompt(MESSAGES[:go_again])
  answer = Kernel.gets().chomp()
  break unless answer.downcase() == 'y' || answer.downcase() == 'yes'
end

prompt(MESSAGES[:goodbye])
