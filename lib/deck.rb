
class Deck

  def self.card_array
    cards = []
    Card.suits_array.each do |suit|
      Card.values_array.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end
  attr_accessor :cards
  def initialize(cards = Deck.card_array)
    @cards = cards.shuffle
  end

  def count
    @cards.count
  end

  def take(n)
    raise "Not enough cards in deck" if n > self.count
    dealt_cards = []
    n.times do
      dealt_cards << self.cards.shift
    end
    dealt_cards
  end

end