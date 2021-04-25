# frozen_string_literal: true

# deck
class Deck
  attr_reader :cards

  SYMBOLS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  MASTS = ["\u{2660}", "\u{2663}", "\u{2665}", "\u{2666}"].freeze

  def initialize
    @cards = create_deck
  end

  def create_deck
    SYMBOLS.map do |symbol|
      MASTS.map { |mast| symbol + mast }
    end.flatten.shuffle
  end
end
