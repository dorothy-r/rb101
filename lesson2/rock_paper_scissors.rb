# Problem:
# Inputs: User enters choice (a string from the list of valid choices)
#         Computer's 'choice' randomly selected from same list
# Ouput: The winner of each game, based on the game logic.
#        The overall winner, whichever player reaches 3 wins first.
#
# Examples:
# Computer chooses 'rock', user inputs 'paper'.
# Output: 'You won this round!' Add (and display?) 1 to player's win score.
# After win score == 3: 'You won!'
# Computer chooses 'paper', user inputs 'paper'.
# Output: 'It's a tie.' Don't increment either score.
#
# Data structures:
# An array of valid choices
# A hash pairing the key (player's choice) with value (a string or array
# showing what the choice will defeat)
#
# Algorithm:
# Provide introduction and instructions
# Ask user to input choice
# Select computer's random choice
# Use the hash to see if either player won.
# Display the winner, or a tie message if neither player won.
# Initialize variables to track user and computer wins
# Increment the appropriate variable after each win
# Until one of these reaches 3, start another game.
# When one of the win variables reaches 3, display the winner.

VALID_CHOICES = { 'rock' =>
                  { alias: 'r',
                    defeats: ['scissors', 'lizard'],
                    verbs: ['(as it always has) crushes', 'crushes'] },
                  'paper' =>
                  { alias: 'p',
                    defeats: ['rock', 'spock'],
                    verbs: ['covers', 'disproves'] },
                  'scissors' =>
                  { alias: 's',
                    defeats: ['paper', 'lizard'],
                    verbs: ['cut', 'decapitate'] },
                  'lizard' =>
                  { alias: 'l',
                    defeats: ['spock', 'paper'],
                    verbs: ['poisons', 'eats']},
                  'spock' =>
                  { alias: 'sp',
                    defeats: ['scissors', 'rock'],
                    verbs: ['smashes', 'vaporizes'] } }

WINNING_SCORE = 3

def prompt(message)
  puts "=> #{message}"
end

def get_choice
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.keys.join(', ')}")
    choice = gets.chomp.downcase
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
    else
      choice
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
  prompt("You chose: #{player}. Computer chose: #{computer}")
end

def display_results(winner)
  if winner == :player
    prompt("You won this round!")
  elsif winner == :computer
    prompt("Computer won this round!")
  else
    prompt("It's a tie!")
  end
end

def increment_score(winner, scores)
  scores[winner] += 1
end

def display_scores(scores)
  scores.each do |k, v|
    prompt("#{k.capitalize}: #{v}")
  end
end

def display_winner(scores)
  if scores[:player] == WINNING_SCORE
    prompt("You are the grand winner!")
  else
    prompt("The computer is the grand winner!")
  end
end

def play_again?
  prompt("Do you want to play again?")
  prompt("If so, enter 'Y'. Enter any other key to exit.")
  answer = gets.chomp
  answer.downcase == 'y'
end

loop do
  system 'clear'
  scores = { player: 0, computer: 0 }
  loop do
    player_choice = get_choice
    computer_choice = VALID_CHOICES.keys.sample

    round_winner = get_winner(player_choice, computer_choice)
    display_choices(player_choice, computer_choice)
    display_results(round_winner)

    increment_score(round_winner, scores) if round_winner
    display_scores(scores)

    break if scores.value?(WINNING_SCORE)
  end

  display_winner(scores)

  break unless play_again?
end

prompt("Thank you for playing. Good bye!")
