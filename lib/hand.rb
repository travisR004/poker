
class Hand

  attr_accessor :cards, :tiebreaker

  def initialize(deck = Deck.new)
    @cards = deck.take(5)
    @deck = deck
    @tiebreaker = nil
  end

  def trade_in(cards_gone)
    raise "Can only draw 3 cards" if cards_gone.count > 3
    cards_gone.each do |idx|
      self.cards[idx] = nil
    end
    self.cards.compact!
    p self.cards.length

    cards_gone.each do |card|
      @cards << @deck.take(1)[0]
    end
  end

  def beats?(other_hand)
    return true if self.hand_type > other_hand.hand_type
    if self.hand_type == other_hand.hand_type
      return true if self.tiebreaker > other_hand.tiebreaker
      return false if self.tiebreaker < other_hand.tiebreaker
      i = 4
      while i >= 0
        return true if self.high_card(i) > other_hand.high_card(i)
        i -= 1
      end
    end
    false
  end

  def hand_type
    return 10 if royal_flush?
    return 9 if straight_flush?
    return 8 if four_of_a_kind?
    return 7 if full_house?
    return 6 if flush?
    return 5 if straight?
    return 5 if three_of_a_kind?
    return 3 if two_pair?
    return 2 if pair?
    1
  end

  protected

  def sort_cards
    @cards.sort_by {|card| card.poker_value}
  end

  def high_card(n)
    self.sort_cards[n].poker_value
  end

  def same_suit?
    @cards.each_index do |index|
      next if index == 0
      return false if @cards[index].suit != @cards[index - 1].suit
    end
    @tiebreaker = self.sort_cards[-1].poker_value
  end

  def consecutive?
    self.sort_cards
    @cards.each_index do |index|
      next if index == 0
      return false if @cards[index].poker_value - @cards[index - 1].poker_value != 1
    end
     @tiebreaker = @cards[-1].poker_value
  end

  def matching?(n)
    poker_values = []
    @cards.each do |card|
      poker_values << card.poker_value
    end

    matching_value = nil

    poker_values.any? do |value|
      if poker_values.count(value) == n
        matching_value = value
      end
    end

     @tiebreaker = matching_value
  end

  def royal_flush?
    self.same_suit? && self.consecutive? && @cards[0].poker_value == 10
  end

  def straight_flush?
    self.same_suit? && self.consecutive?
  end

  def four_of_a_kind?
    self.matching?(4)
  end

  def full_house?
    self.matching?(3) && self.cards.map {|card| card.value}.uniq.length == 2
  end

  def flush?
    self.same_suit?
  end

  def straight?
    self.consecutive?
  end

  def three_of_a_kind?
    self.matching?(3)
  end

  def two_pair?
    self.matching?(2) && self.cards.uniq == 3
  end

  def pair?
    self.matching?(2)
  end




end