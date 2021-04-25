require_relative 'player'

# Dealer
class Dealer < Player
  def hide_cards
    puts "#{self.name} cards: #{'*' * cards.size}"
  end
end
