# frozen_string_literal: true

require_relative 'player'

# Dealer
class Dealer < Player
  def hide_cards
    puts "Dealer cards: #{'*' * cards.size}"
  end
end
