require 'game'
require 'rspec'
require 'player'
require 'deck'
require 'hand'



describe "game" do
  subject(:game) {Game.new}
  let(:player1) {Player.new("Bob", 1000)}
  let(:player2) {Player.new("Travis", 500)}

  describe "pot" do
    it "increases after a player bets" do
      player1.bets(50)
      expect(game.pot).to eq(50)
    end

    it "pays out the pot to winner" do
      game.pay_winnings(player2)
      expect(player2.wallet).to eq(550)
    end

  end