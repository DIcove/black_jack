# frozen_string_literal: true

# card
class Card
  @suits_index = 0
  @symbols_index = 0

  class << self
    attr_accessor :suits_index, :symbols_index
  end

  attr_reader :symbol, :suit

  SYMBOLS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = ["\u{2660}", "\u{2663}", "\u{2665}", "\u{2666}"].freeze

  def initialize # rubocop:todo Metrics/AbcSize
    @symbol = SYMBOLS[self.class.symbols_index]
    @suit = SUITS[self.class.suits_index]
    self.class.symbols_index += 1 if self.class.suits_index == 3
    self.class.suits_index == 3 ? self.class.suits_index = 0 : self.class.suits_index += 1
  end
end
