require 'hand'
require 'player'
require 'rspec'

describe "player" do
  subject(:player) {Player.new("Bob", 1000, Deck.new)}

  describe "betting" do
    it "should subtract bet from wallet" do
      player.bet(400)
      expect(player.wallet).to eq(600)
    end

  end

  describe "exchange" do
    it "should raise an error if invalid index" do
      expect do
        player.exchange([0,4,5])
      end.to raise_error "Invalid card"
    end
  end

  describe "call" do
    it "should subtract call amount from wallet" do
      player.call(25)
      expect(player.wallet).to eq(975)
    end
  end

  describe "fold" do
    it "should set the players hand to nil" do
      player.fold
      expect(player.hand).to eq(nil)
    end
  end

  describe "raise" do
    it "should both call and bet" do
      player.raise_to(50, 100)
      expect(player.wallet).to eq(850)
    end
  end

end


