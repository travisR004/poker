require 'deck'
require 'rspec'
describe "deck" do
  subject(:deck) { Deck.new }

  describe "new deck" do
    it "should be 52 cards" do
      expect(deck.count).to eq(52)
    end
  end

  describe "take or deal cards" do
    it "should deal 5 cards per player" do
      current_deck = deck.count
      deck.take(5)
      expect(deck.count).to eq(current_deck - 5)
    end

    it "should deal 2 cards per player" do
      current_deck = deck.count
      deck.take(2)
      expect(deck.count).to eq(current_deck - 2)
    end

    it "shouldn't overdraw the deck" do
      current_deck = deck.count
      expect do
        deck.take(53)
      end.to raise_error "Not enough cards in deck"
    end
  end
end

