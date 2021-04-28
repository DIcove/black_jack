# frozen_string_literal: true

require_relative 'requirable'

# Game
class Game # rubocop:todo Metrics/ClassLength
  def initialize
    @user_interface = UserInterface.new
    initial_players
    start_game
  end

  private

  COMMANDS = {
    1 => :pass,
    2 => :take_card,
    3 => :summarize
  }.freeze

  attr_reader :players, :user_hands, :dealer_hands, :user, :dealer, :deck, :bank, :bet, :user_interface, :hands

  def initial_players
    @user = User.new(user_interface.ask_name)
    @dealer = Dealer.new('dealer')
    @players = { user: user, dealer: dealer }
    initial_hands
  end

  def initial_hands
    @user_hands = UserHand.new(user)
    @dealer_hands = DealerHand.new(dealer)
    @hands = { user_hands: user_hands, dealer_hands: dealer_hands }
  end

  def reset_values
    reset_cards
    reset_deck
    reset_bank
  end

  def reset_cards
    hands.each_value do |hand|
      hand.cards.clear
    end
  end

  def reset_bank
    @bank = Bank.new
  end

  def reset_deck
    @deck = Deck.new
  end

  def start_game
    reset_values
    make_bet
    give_cards
    first_move
  end

  def make_bet
    players.each_value { |player| player.make_bet(bank) }
  end

  def first_move
    players.values.sample.is_a?(User) ? user_turn : dealer_turn
  end

  def give_cards
    2.times do
      hands.each_value { |hand| hand.take_card(deck) }
    end
  end

  def user_turn
    summarize if max_cards?
    user_interface.show_menu(players, hands)
    selection
  end

  def selection
    command = user_interface.select_options
    send(COMMANDS[command])
  end

  def pass
    dealer_turn
  end

  def take_card
    if user_hands.cards.size == 3
      user_interface.cards_limit_error
      user_turn
    else
      user_hands.take_card(deck)
      dealer_turn
    end
  end

  def summarize
    user_interface.reveal_cards(players, hands)
    determine_winner
    restart_game!
  end

  def dealer_turn
    summarize if max_cards?
    dealer_hands.take_card(deck) if dealer.points < 17
    user_interface.show_menu(players, hands)
    user_turn
  end

  def max_cards?
    hands.values.all? { |hand| hand.cards.size == 3 }
  end

  def determine_winner
    user_points = user.points
    dealer_points = dealer.points

    return draw if user_points == dealer_points

    arr = [user_points, dealer_points].sort
    winner_points = arr[1] > 21 ? arr[0] : arr[1]
    winner_points == user_points ? user_won : dealer_won
  end

  def user_won
    user_interface.winning_message(user)
    bank.return_cash(user, bank.bet)
  end

  def dealer_won
    user_interface.winning_message(dealer)
    bank.return_cash(dealer, bank.bet)
  end

  def draw
    user_interface.draw_message
    bank.return_cash(user, 10)
    bank.return_cash(dealer, 10)
  end

  def restart_game!
    input = user_interface.ask_for_restart
    input.downcase.start_with?('y') ? start_game : exit!
  end
end

Game.new
