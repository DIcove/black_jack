# frozen_string_literal: true

require_relative 'requirable'

# Game
class Game # rubocop:todo Metrics/ClassLength
  include UserInterface

  def initialize
    puts GREETINGS
    @players = []
    initial_players
    start_game
  end

  private

  attr_reader :players, :user, :dealer, :deck, :bank, :bet

  def initial_players
    @user = User.new(ask_name)
    @dealer = Dealer.new('dealer')
    players.push(user, dealer)
  end

  def reset_values
    players.each do |player|
      player.cards.clear
      player.points = 0
    end

    reset_deck
    reset_bank
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
    players.each { |player| player.make_bet(bank) }
  end

  def first_move
    players.sample.is_a?(User) ? user_turn : dealer_turn
  end

  def give_cards
    2.times do
      players.each { |player| player.take_card(deck) }
    end
  end

  def user_turn
    reveal_cards if max_cards?
    show_menu
    show_options
    selection
  end

  def selection
    command = gets.chomp.strip.to_i
    send(COMMANDS[command])
  end

  def separation
    15.times { print '=' }
    puts
  end

  def pass
    dealer_turn
  end

  def take_card
    if user.cards.size == 3
      puts 'can\'t take more cards...'
      user_turn
    else
      user.take_card(deck)
      dealer_turn
    end
  end

  def reveal_cards
    dealer.reveal_cards
    separation
    user.reveal_cards

    determine_winner
    restart_game!
  end

  def show_menu
    dealer.hide_cards
    separation
    user.reveal_cards
    reveal_cards if max_cards?
  end

  def dealer_turn
    reveal_cards if max_cards?
    dealer.points >= 17 ? user_turn : dealer.take_card(deck)
    show_menu
  end

  def max_cards?
    players.all? { |player| player.cards.size == 3 }
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
    puts "#{user.name} won!!!"
    bank.return_cash(user, bank.bet)
    puts user.cash
  end

  def dealer_won
    puts 'dealer won!!!'
    bank.return_cash(dealer, bank.bet)
    puts dealer.cash
  end

  def draw
    puts 'DRAW!'
    bank.return_cash(user, 10)
    bank.return_cash(dealer, 10)
  end

  def restart_game!
    puts 'Wanna play again??? (yes/no)'
    input = gets.chomp.strip
    input.downcase.start_with?('y') ? start_game : exit!
  end
end

Game.new
