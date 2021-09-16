require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key, language, replacement='to_change')
  message = format(messages(key, language), var: replacement)
  Kernel.puts("=> #{message}")
end

def lang_choice
  language = ''
  loop do
    lang = Kernel.gets().chomp()

    if lang == '1'
      language = 'en'
      break
    elsif lang == '2'
      language = 'es'
      break
    end
    prompt(:valid_language)
  end
  language
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

def get_operator
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

def divide_by_zero?(operator, number)
  operator == '4' && number == 0.0
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

prompt(:get_language, "en")

language = lang_choice()

prompt(:welcome, language)

name = get_name()

prompt(:hello, language, name)
Kernel.sleep(1)

loop do
  Kernel.system("clear")

  prompt(:first_number, language)
  number1 = get_number()

  prompt(:second_number, language)
  number2 = get_number()

  prompt(:operator_prompt, language)

  operator = get_operator()

  Kernel.system("clear")

  prompt(:operation, language)

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

  if divide_by_zero?(operator, number2)
    prompt(:zero_division, language)
  else
    prompt(:result, language, result)
  end

  prompt(:go_again, language)
  answer = Kernel.gets().chomp()
  break unless answer.downcase() == 'y' || answer.downcase() == 'yes'
end

prompt(:goodbye, language)
