# frozen_string_literal: true

# deck
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_deck
    p cards
  end

  def create_deck
    # SYMBOLS.map do |symbol|
    #   MASTS.map { |mast| Card.new(symbol + mast) }
    52.times do
      cards << Card.new
    end
  end
end
