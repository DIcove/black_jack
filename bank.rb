# bank
class Bank
  attr_accessor :bet

  def initialize
    @bet = 0
  end

  def return_cash(player, amount)
    player.cash += amount
  end
end
