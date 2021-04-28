# frozen_string_literal: true

# card
class Card
  attr_reader :symbol, :suit

  SYMBOLS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = ["\u{2660}", "\u{2663}", "\u{2665}", "\u{2666}"].freeze

  def initialize(symbol, suit)
    @symbol = symbol
    @suit = suit
  end
end
