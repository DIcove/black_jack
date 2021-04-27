# frozen_string_literal: true

# dealer_hand
class DealerHand < Hand
  def hide_cards
    "Dealer cards: #{'*' * cards.size}"
  end
end
