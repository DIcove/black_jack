# frozen_string_literal: true

# hand
class Hand
  attr_reader :cards, :player

  def initialize(player)
    @cards = []
    @player = player
  end

  def take_card(deck)
    cards << deck.cards.pop
    count_points
  end

  def count_points # rubocop:todo Metrics/MethodLength
    player.points = 0
    cards.each do |card|
      num = if %w[J Q K].include?(card.symbol)
              10
            elsif card.symbol == 'A'
              player.points < 11 ? 11 : 1
            else
              card.symbol.to_i
            end
      player.points += num
    end
  end

  def reveal_cards
    "#{player.name} cards: #{cards}, points #{player.points}"
  end
end
