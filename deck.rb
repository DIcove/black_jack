# frozen_string_literal: true

# deck
class Deck
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    Card::SYMBOLS.map do |symbol|
      Card::SUITS.map { |suit| Card.new(symbol, suit) }
    end.flatten.shuffle
  end
end
