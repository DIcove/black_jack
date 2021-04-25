# frozen_string_literal: true

# user interface
module UserInterface
  GREETINGS = 'Welcome to black jack, gl, hf'

  OPTIONS = %w[
    Pass
    Take\ card\ from\ deck
    Reveal\ cards
  ].freeze

  COMMANDS = {
    1 => :pass,
    2 => :take_card,
    3 => :reveal_cards
  }.freeze

  def ask_name
    puts 'Enter your name...'
    gets.chomp.strip
  end

  def show_options
    puts 'You can choose between options:'
    OPTIONS.each.with_index(1) { |opt, i| puts "#{i}. #{opt}" }
  end
end
