require './player.rb'
require './hand.rb'
require './deck.rb'
require './card.rb'

class Game

  def initialize
    @deck = Deck.new
    get_players
    @pot = 0

  end

  def play_hand
    while true
      @pot = 0
      @raised_amt = 0
      @deck = Deck.new
      self.start_hand
      self.show_hands
      self.betting_phase
      self.exchange_card
      self.show_hands
      self.betting_phase
      self.show_hands
      self.find_winning_hand
      puts "#{@winning_player.name} won this hand!!!"
      puts "Play another hand? (y/n)"
      choice = gets.chomp
      break if choice == "n"
    end
  end

  def show_hands
    @players.each do |player|
      next if player.hand == nil
      puts "#{player.name}: #{player.hand.cards.map {|card| [card.suit, card.value]} }"
    end
  end

  def get_players
    begin
      puts "Enter number of players (1-4)"
      player_no = Integer(gets.chomp)
      raise "Invalid number" if !player_no.between?(1, 4)
    rescue
      retry
    end
    @players = []
    player_no.times do
      puts "Enter player name"
      player_name = gets.chomp
      @players << Player.new(player_name, @deck)
    end
    @players
  end

  def start_hand
    @players.each do |player|
      player.get_hand(@deck)
    end
  end

  def player_move_input(player)
   begin
      puts "#{player.name}: fold, call, or raise."
      puts "To call: #{@raised_amt - player.total_bet}"
      choice = gets.chomp
      raise "Invalid entry" if !(["fold", "call", "raise"]).include?(choice)
    rescue
      retry
    end
    choice
  end


  def betting_phase
    while true
      @players.each do |player|
        p "pot: #{@pot} "
        p "player total_bet: #{player.total_bet}"
        p "Raised_amt: #{@raised_amt}"
        next if player.hand == nil
        next if @raised_amt - player.total_bet == 0 && @raised_amt != 0
        choice = self.player_move_input(player)
        if choice == "fold"
          player.fold
        elsif choice == "call"
          @pot += @raised_amt - player.total_bet
          player.call(@raised_amt - player.total_bet)
        elsif choice == "raise"
          begin
            puts "Enter raise amount."
            raise_amt = Integer(gets.chomp)
            player.raise_to(@raised_amt - player.total_bet, raise_amt)
            @pot += raise_amt + @raised_amt - player.total_bet
            @raised_amt += raise_amt
          rescue
            retry
          end
        end
      end
      break if betting_over?
    end
  end

  def exchange_card
    @players.each do |player|
      puts "Enter indices of cards to exchange (eg: 0,1,2)"
      card_indices = gets.chomp.split(',').map(&:to_i)
      player.exchange(card_indices)
    end
  end

  def betting_over?
    check = true
    @players.each do |player|
      next if player.total_bet == @raised_amt
      check = false
    end
    check
 end




  def find_winning_hand
    @winning_player = nil

    @players.each do |player1|
      next if player1.hand.nil?
      @players.each do |player2|
        next if player1 == player2
        next if player2.hand.nil?
        next if player2.hand.beats?(player1.hand)
        @winning_player = player1
      end
    end
   @winning_player.pay_winnings(@pot)
   @winning_player
 end

end


g = Game.new
g.play_hand