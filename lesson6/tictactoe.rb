require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INIT_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYERS = {1 => 'player', 2 => 'computer'}

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INIT_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INIT_MARKER }
end

def joinor(arr, punct = ', ', word = 'or')
  if arr.size == 1
    arr[0]
  elsif arr.size == 2
    arr.join(" #{word} ")
  else
    arr.slice(0, arr.size - 1).join(punct) + "#{punct}#{word} #{arr[-1]}"
  end
end

def select_first_player
  prompt "Who should go first? Enter 1 for yourself, 2 for the computer," +
    " or 3 to let the computer choose:"
  choice = gets.chomp.to_i
  if choice == 3
    PLAYERS.values.sample
  else
    PLAYERS[choice]
  end
end

def place_piece!(brd, player)
  player == 'player' ? player_places_piece!(brd) : computer_places_piece!(brd)
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def priority_lines(brd, marker)
  WINNING_LINES.select do |line|
    brd.values_at(*line).count(marker) == 2 &&
      brd.values_at(*line).count(INIT_MARKER) == 1
  end
end

def find_open_square(brd, lines)
  square = ''
  lines.each do |line|
    square = brd.select { |k, v| line.include?(k) && v == INIT_MARKER }.keys[0]
  end
  square
end

def computer_places_piece!(brd)
  winner_lines = priority_lines(brd, COMPUTER_MARKER)
  risky_lines = priority_lines(brd, PLAYER_MARKER)
  square = if winner_lines.any?
             find_open_square(brd, winner_lines)
           elsif risky_lines.any?
             find_open_square(brd, risky_lines)
           elsif brd[5] == INIT_MARKER
             5
           else
             empty_squares(brd).sample
           end
  brd[square] = COMPUTER_MARKER
end

def alternate_player(player)
  player == 'computer' ? player = 'player' : player = 'computer' 
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).all?(PLAYER_MARKER)
      return "Player"
    elsif brd.values_at(*line).all?(COMPUTER_MARKER)
      return "Computer"
    end
  end
  nil
end

loop do
  computer_score = 0
  player_score = 0

  loop do
    board = initialize_board
    current_player = select_first_player
    puts current_player
    sleep 1

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
      detect_winner(board) == 'Player' ? player_score += 1 : computer_score += 1
    else
      prompt "It's a tie!"
    end

    break if player_score == 5 || computer_score == 5

    prompt "Current Score:"
    prompt "Player: #{player_score}"
    prompt "Computer: #{computer_score}"
    sleep 2
  end

  prompt "Final Score:"
  prompt "Player: #{player_score}"
  prompt "Computer: #{computer_score}"
  prompt "Good game!\n"
  sleep 1

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
