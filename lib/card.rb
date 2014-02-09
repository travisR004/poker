# -*- coding: utf-8 -*-

class Card

  SUITS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUES = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  POKER_VALUE = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace => 14
  }

  def self.values_array
    VALUES.keys
  end

  def self.suits_array
    SUITS.keys
  end

  attr_reader :suit, :value, :poker_value

  def initialize(suit, value)
    @suit = suit
    @value = value
    @poker_value = POKER_VALUE[@value]
  end



end