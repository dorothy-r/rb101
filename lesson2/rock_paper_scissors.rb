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

VALID_CHOICES = { 'rock' => 'r',
                  'paper' => 'p',
                  'scissors' => 's',
                  'lizard' => 'l',
                  'spock' => 'sp' }
WINNERS = { 'rock' => ['scissors', 'lizard'],
            'paper' => ['rock', 'spock'],
            'scissors' => ['paper', 'lizard'],
            'lizard' => ['spock', 'paper'],
            'spock' => ['scissors', 'rock'] }
WINNING_SCORE = 3

def prompt(message)
  puts "=> #{message}"
end

def get_choice
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.keys.join(', ')}")
    choice = gets.chomp

    if VALID_CHOICES.key?(choice)
      break
    elsif VALID_CHOICES.value?(choice)
      choice = VALID_CHOICES.key(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end
  choice
end

def win?(first, second)
  WINNERS[first].include?(second)
end

def display_results(player, computer)
  prompt("You chose: #{player}. Computer chose: #{computer}")
  if win?(player, computer)
    prompt("You won this round!")
  elsif win?(computer, player)
    prompt("Computer won this round!")
  else
    prompt("It's a tie!")
  end
end

loop do
  system 'clear'
  player_score = 0
  computer_score = 0
  loop do
    player_choice = get_choice
    computer_choice = VALID_CHOICES.keys.sample

    display_results(player_choice, computer_choice)

    if win?(player_choice, computer_choice)
      player_score += 1
    elsif win?(computer_choice, player_choice)
      computer_score += 1
    end

    break if player_score == WINNING_SCORE || computer_score == WINNING_SCORE
  end

  if player_score == WINNING_SCORE
    prompt("You are the grand winner!")
  else
    prompt("The computer is the grand winner!")
  end

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
