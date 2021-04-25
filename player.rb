# Player
class Player
  attr_reader :name, :cards
  attr_accessor :points, :cash

  def initialize(name)
    @name = name
    @cards = []
    @cash = 100
  end

  def count_points
    @points ||= 0
    cards.each do |card|
      # value = case card.starts_with?
      #         when 'J', 'Q', 'K'
      #           10
      #         when 'A'
      #           points > 10 ? 1 : 11
      #         else
      #           card.to_i
      #         end
      num = if card.start_with?('J', 'Q', 'K')
                 10
               elsif card.start_with?('A')
                 points > 10 ? 1 : 11
               else
                 card.to_i
               end
      self.points += num
    end
  end

  def take_card(deck)
    cards << deck.cards.pop
    count_points
  end

  def reveal_cards
    puts "#{name} cards: #{cards}, points #{points}"
  end

  def make_bet(bank)
    self.cash -= 10
    bank.bet += 10
  end
end

# card = 'JA'
# val = card[0]
# case card.start_with?(val)
# when 'J'
#   puts 'success'
# else
#   puts 'error'
# end
