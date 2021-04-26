# frozen_string_literal: true

# Player
class Player
  attr_reader :name
  attr_accessor :cash, :points

  def initialize(name)
    @name = name
    @cash = 100
    @points = 0
  end

  def make_bet(bank)
    self.cash -= 10
    bank.bet += 10
  end
end
