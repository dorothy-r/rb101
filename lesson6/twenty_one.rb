=begin
To do later:
  Store the total in a local variable (instead of `calculate` when we need it)
  Figure out end-of-round conditions and outpus better
  Play multiple rounds; first to 5 wins
  Store winning score and dealer stopping point as constants
  Input validation
  General refactoring
  Make sure methods are doing one thing
=end
SUITS = %w(♣️ ♦️ ♠️ ♥️)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  new_deck = {}
  SUITS.each do |suit|
    VALUES.each do |value|
      new_deck[value + suit] = if value == 'A'
                                 [1, 11]
                               elsif %w(J Q K).include?(value)
                                 10
                               else
                                 value.to_i
                               end
    end
  end
  new_deck
end

def deal!(deck)
  cards = {}
  2.times do
    current_card = deck.keys.sample
    cards[current_card] = deck[current_card]
    deck.delete(current_card)
  end
  cards
end

def player_turn(hand1, hand2, deck)
  loop do
    player_value = calculate_hand(hand1)
    display_player_turn(hand1, hand2, player_value)
    prompt "Would you like to hit or stay? Enter 1 to hit, 2 to stay."
    choice = gets.chomp
    hit!(hand1, deck) if choice == '1'
    break if choice == '2' || busted?(hand1)
  end
  if busted?(hand1)
    prompt "Oh no! You busted! Dealer wins."
    hand1[:busted] = true
  end
end

def dealer_turn(hand, deck)
  loop do
    dealer_value = calculate_hand(hand)
    display_dealer_turn(hand, dealer_value)
    break if dealer_value >= 17 || busted?(hand)
    hit!(hand, deck)
  end
  if busted?(hand)
    prompt "Dealer busted! You win!"
    hand[:busted] = true
  end
end

def calculate_hand(hand)
  total = 0
  aces = []
  hand.each_value do |value|
    value.is_a?(Array) ? aces << value : total += value
  end
  aces.each do |ace|
    total += total > 10 ? ace[0] : ace[1]
  end
  total
end

def display_player_turn(hand1, hand2, value)
  prompt "Your cards are: #{joinand(hand1.keys)}"
  prompt "Current value: #{value}"
  prompt "Dealer is showing: #{hand2.keys.first}"
end

def display_dealer_turn(hand, value)
  prompt "Dealer's cards are: #{joinand(hand.keys)}"
  prompt "Current value: #{value}"
end

def joinand(arr, punct = ', ', word = 'and')
  if arr.size == 1
    arr[0]
  elsif arr.size == 2
    arr.join(" #{word} ")
  else
    arr.slice(0, arr.size - 1).join(punct) + "#{punct}#{word} #{arr[-1]}"
  end
end

def hit!(hand, deck)
  current_card = deck.keys.sample
  hand[current_card] = deck[current_card]
  deck.delete(current_card)
end

def busted?(hand)
  calculate_hand(hand) > 21
end

def compare_scores(hand1, hand2)
  calculate_hand(hand1) > calculate_hand(hand2) ? "Player" : "Dealer"
end

def display_results(hand1, hand2, winner)
  prompt "Your hand's value: #{calculate_hand(hand1)}"
  prompt "Dealer hand's value: #{calculate_hand(hand2)}"
  prompt "#{winner} wins!"
end

loop do
  deck = initialize_deck
  player_hand = deal!(deck)
  dealer_hand = deal!(deck)

  player_turn(player_hand, dealer_hand, deck)
  dealer_turn(dealer_hand, deck) unless player_hand[:busted]
  unless player_hand[:busted] || dealer_hand[:busted]
    winner = compare_scores(player_hand, dealer_hand)
    display_results(player_hand, dealer_hand, winner)
  end
  prompt "Would you like to play again? Enter y or n"
  answer = gets.chomp
  break if answer.downcase == 'n'
end
