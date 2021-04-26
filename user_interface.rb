# frozen_string_literal: true

# user interface
class UserInterface
  GREETINGS = 'Welcome to black jack, gl, hf'

  OPTIONS = %w[
    Pass
    Take\ card\ from\ deck
    Reveal\ cards
  ].freeze

  def initialize
    puts GREETINGS
  end

  def ask_name
    puts 'Enter your name...'
    gets.chomp.strip
  end

  def show_options
    puts 'You can choose between options:'
    OPTIONS.each.with_index(1) { |opt, i| puts "#{i}. #{opt}" }
  end

  def show_menu(hands)
    puts hands[:dealer_hands].hide_cards
    separation
    puts hands[:user_hands].reveal_cards
  end

  def reveal_cards(hands)
    puts hands[:dealer_hands].reveal_cards
    separation
    puts hands[:user_hands].reveal_cards
  end

  def select_options
    show_options
    gets.chomp.strip.to_i
  end

  def separation
    15.times { print '=' }
    puts
  end

  def cards_limit_error
    puts 'can\'t take more cards...'
  end

  def ask_for_restart
    puts 'Wanna play again??? (yes/no)'
    gets.chomp.strip
  end

  def winning_message(player)
    puts "#{player.name} won!!!"
  end

  def draw_message
    puts 'Draw!!!'
  end
end
