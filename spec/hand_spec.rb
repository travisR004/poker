require 'hand'
require 'card'
require 'rspec'

describe 'hand' do
  subject(:hand) { Hand.new }

  it "should have 5 cards" do
    expect(hand.cards.count).to eq(5)
  end

  it "should be able to trade in cards" do
    initial_hand = hand.dup
    hand.trade_in([hand.cards[0], hand.cards[2]])
    expect(hand == initial_hand).to eq(false)
    expect(hand.cards.count).to eq(5)
    p initial_hand
    p hand
  end

  it "should not be able to trade in more than 3 cards" do
    expect do
      hand.trade_in(hand.cards[0..3])
    end.to raise_error "Can only draw 3 cards"
  end

  it "should return a hands value" do
    hand.cards = [Card.new(:diamond, :deuce), Card.new(:diamond, :three),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :six)]
    expect(hand.hand_type).to eq(9)

    hand.cards = [Card.new(:diamond, :deuce), Card.new(:spade, :deuce),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :six)]
    expect(hand.hand_type).to eq(2)

    hand.cards = [Card.new(:diamond, :deuce), Card.new(:spade, :deuce),
    Card.new(:diamond, :four), Card.new(:spade, :four), Card.new(:club, :four)]
    expect(hand.hand_type).to eq(7)
  end

  it "should determine which hand wins" do
    hand.cards = [Card.new(:diamond, :deuce), Card.new(:diamond, :three),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :six)]
    hand2 = Hand.new([Card.new(:diamond, :deuce), Card.new(:spade, :deuce),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :six)])
    expect(hand.beats?(hand2)).to eq(true)
  end

  it "handles a tie" do
    hand.cards = [Card.new(:diamond, :deuce), Card.new(:spade, :deuce),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :ace)]
    hand2 = Hand.new([Card.new(:club, :deuce), Card.new(:heart, :deuce),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :six)])
    expect(hand.beats?(hand2)).to eq(true)
  end

  it "picks high hand on tie" do
    hand.cards = [Card.new(:diamond, :four), Card.new(:spade, :four),
    Card.new(:diamond, :ten), Card.new(:diamond, :five), Card.new(:diamond, :six)]
    hand2 = Hand.new([Card.new(:club, :deuce), Card.new(:heart, :deuce),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :ace)])
    expect(hand.beats?(hand2)).to eq(true)
  end

  it "handles a loss on tie" do
    hand.cards = [Card.new(:diamond, :four), Card.new(:spade, :four),
    Card.new(:diamond, :ten), Card.new(:diamond, :five), Card.new(:diamond, :six)]
    hand2 = Hand.new([Card.new(:club, :deuce), Card.new(:heart, :deuce),
    Card.new(:diamond, :four), Card.new(:diamond, :five), Card.new(:diamond, :ace)])
    expect(hand2.beats?(hand)).to eq(false)
  end

  it "handles a 4 card tie" do
    hand.cards = [Card.new(:diamond, :four), Card.new(:spade, :four),
    Card.new(:diamond, :ten), Card.new(:diamond, :ten), Card.new(:diamond, :six)]
    hand2 = Hand.new([Card.new(:club, :four), Card.new(:heart, :four),
    Card.new(:diamond, :ten), Card.new(:diamond, :ten), Card.new(:diamond, :five)])
    expect(hand.beats?(hand2)).to eq(true)
  end

end


