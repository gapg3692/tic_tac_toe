# frozen_string_literal: true

# Boar is a class
class Board
  attr_reader :player1, :player2

  def initialize
    new_game
  end

  def game
    print_board
    puts "Player #{@player_to_play} make your move, choose a number between 1-9"
    play = gets.chomp
    if @plays.include?(play)
      player_play(@player_to_play, play)
      if result(@player_to_play) == 'continue'
        @player_to_play = @player_to_play == 1 ? 2 : 1
        game
      end
    else
      puts 'not valid play, choose again'
      game
    end
  end

  private

  def print_board
    @board = "\n #{@plays[0]} | #{@plays[1]} | #{@plays[2]}  \n---+---+---\n #{@plays[3]} | #{@plays[4]} | #{@plays[5]} \n---+---+---\n #{@plays[6]} | #{@plays[7]} | #{@plays[8]}  \n\n"
    puts @board
  end

  def player_play(player, play)
    if player == 1
      @player1.push(play.to_i)
      @plays[play.to_i - 1] = 'X'
    else
      @player2.push(play.to_i)
      @plays[play.to_i - 1] = 'O'
    end
  end

  def new_game
    @player1 = []
    @player2 = []
    @plays = %w[1 2 3 4 5 6 7 8 9]
    @player_to_play = 1
    puts 'Welcome to the tic-tac-toe game!'
  end

  def result(player)
    array = player == 1 ? @player1 : @player2
    if combination?(array)
      puts "Player #{@player_to_play} you win!"
      print_board
    elsif !(@player1.length == 5 && @player2.length == 4)
      'continue'
    else
      puts "That's a tie!"
      print_board
    end
  end

  def combination?(array)
    array.permutation(3) do |combination|
      if [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9],
          [3, 5, 7]].include?(combination)
        return true
      end
    end
    false
  end
end

test = Board.new
test.game
