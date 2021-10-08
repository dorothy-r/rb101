VALID_CHOICES = { 'rock' =>
                  { alias: 'r',
                    defeats: ['scissors', 'lizard'],
                    verbs: ['crushes', 'crushes'] },
                  'paper' =>
                  { alias: 'p',
                    defeats: ['rock', 'spock'],
                    verbs: ['covers', 'disproves'] },
                  'scissors' =>
                  { alias: 'sc',
                    defeats: ['paper', 'lizard'],
                    verbs: ['cut', 'decapitate'] },
                  'lizard' =>
                  { alias: 'l',
                    defeats: ['spock', 'paper'],
                    verbs: ['poisons', 'eats'] },
                  'spock' =>
                  { alias: 'sp',
                    defeats: ['scissors', 'rock'],
                    verbs: ['smashes', 'vaporizes'] } }

WINNING_SCORE = 3

WELCOME = <<~MSG
  Welcome to Rock, Paper, Scissors, Lizard, Spock!
  ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~

  Would you like to review the rules (y/n)?
  MSG

BEGIN_GAME = <<~MSG
  The computer is challenging you to a game.

  Win 3 rounds and you will be named the grand winner!

  Press 'enter' when you are ready to begin. Good luck!
  MSG

RULES = <<~MSG
  ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~

  The Rules:
  Scissors cut Paper      Paper covers Rock
  Rock crushes Lizard     Lizard poisons Spock
  Spock smashes Scissors  Scissors decapitate Lizard
  Lizard eats Paper       Paper disproves Spock
  Spock vaporizes Rock    Rock crushes Scissors

  
  You can enter your choice's full name or use a shortcut:
  'r' for rock, 'p' for paper, 'sc' for scissors, 
  'l' for lizard, 'sp' for spock

 
  Got it? Press 'enter' to continue.

  ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~
  MSG

def prompt(message)
  puts "=> #{message}"
end

def introduction
  system 'clear'
  puts WELCOME
  answer = ''
  loop do
    answer = gets.strip.downcase
    break if %w(y yes n no).include? answer
    prompt("Please enter '(y)es' or '(n)o'")
  end
  if answer == 'y' || answer == 'yes'
    puts RULES
    gets
  end
  system 'clear'
  puts BEGIN_GAME
  gets
end

def get_choice
  choice = ''
  loop do
    prompt("Choose one: ")
    prompt("(r)ock, (p)aper, (sc)issors, (l)izard, (sp)ock")
    choice = gets.strip.downcase
    choice = convert_input(choice)
    break if valid_choice?(choice)
    prompt("That's not a valid choice.")
  end
  choice
end

def convert_input(choice)
  VALID_CHOICES.each do |_k, v|
    if v.value?(choice)
      choice = VALID_CHOICES.key(v)
    end
  end
  choice
end

def valid_choice?(choice)
  VALID_CHOICES.key?(choice)
end

def win?(first, second)
  VALID_CHOICES[first][:defeats].include?(second)
end

def get_winner(player, computer)
  if win?(player, computer)
    :player
  elsif win?(computer, player)
    :computer
  end
end

def display_choices(player, computer)
  prompt("You chose: #{player}")
  sleep 0.5
  prompt("....")
  sleep 0.5
  prompt("Computer chose: #{computer}")
end

def display_results(winner, player, computer)
  puts "\n"
  if winner == :player
    winner = player
    loser = computer
  elsif winner == :computer
    winner = computer
    loser = player
  else
    prompt("You chose the same thing.")
    return
  end
  index = VALID_CHOICES[winner][:defeats].index(loser)
  verb = VALID_CHOICES[winner][:verbs][index]
  prompt("*** #{winner.capitalize} #{verb} #{loser}. ***")
end

def display_round_winner(winner)
  if winner == :player
    prompt("You won this round!")
  elsif winner == :computer
    prompt("Computer won this round!")
  else
    prompt("It's a tie!")
  end
  puts "\n"
end

def increment_score(winner, scores)
  scores[winner] += 1
end

def display_scores(scores)
  prompt("Current Scores:")
  scores.each do |k, v|
    prompt("#{k.capitalize}: #{v}")
  end
  puts "\n"
  prompt("Press 'enter' to continue")
  gets
end

def display_grand_winner(scores)
  if scores[:player] == WINNING_SCORE
    prompt("You are the grand winner! Congratulations!")
  else
    prompt("The computer is the grand winner! Try again.")
  end
  puts "\n"
end

def play_again?
  prompt("Do you want to play again?")
  prompt("If so, enter 'Y'. Enter any other key to exit.")
  answer = gets.strip
  answer.downcase == 'y' || answer.downcase == 'yes'
end

introduction
loop do
  system 'clear'
  scores = { player: 0, computer: 0 }
  loop do
    player_choice = get_choice
    computer_choice = VALID_CHOICES.keys.sample

    round_winner = get_winner(player_choice, computer_choice)
    display_choices(player_choice, computer_choice)
    sleep 0.5
    display_results(round_winner, player_choice, computer_choice)
    display_round_winner(round_winner)
    sleep 0.5

    increment_score(round_winner, scores) if round_winner
    display_scores(scores)
    system 'clear'

    break if scores.value?(WINNING_SCORE)
  end

  display_grand_winner(scores)

  break unless play_again?
end

prompt("Thank you for playing. Good bye!")
