class Player
  attr_reader :name
  attr_accessor :wallet, :hand, :total_bet

  def initialize(name, deck)
    @name = name
    @wallet = 1000
    self.get_hand(deck)
    @total_bet = 0
  end

  def pay_winnings(val)
    @wallet += val
  end

  def get_hand(deck)
    @hand = Hand.new(deck)
  end

  def exchange(cards)
    raise "Invalid card" if cards.any? {|card| !card.between?(0, 4)}

    self.hand.trade_in(cards)
  end

  def bet(val)
    raise "Not enough money." if val > @wallet
    self.wallet -= val
    @total_bet += val
    val
  end

  def call(val)
    self.wallet -= val
    @total_bet += val
  end

  def fold
    self.hand = nil
  end

  def raise_to(to_call, r_amt)
    self.call(to_call)
    self.bet(r_amt)
  end


end