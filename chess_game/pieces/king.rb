require 'colorize'
require './piece.rb'

class King < Piece
  def initialize(color)
    super(color)
  end

  def to_string
    if color
      "K  ".white
    else
      "K  ".black
    end
  end

  def to_sym
    if color
        return :kw
    else
      return :kb
    end
  end

  # returns an array of possible moves from position parameter (an array with 2 elements) (e.g. [0,0] means piece is at position 0,0)
  def possible_moves(position, board, color)
    out_array = []

    x = position[0]-1
    y = position[1]-1

    (x..x+2).each do |row|
      break if row > 7
      (y..y+2).each do |column|
        break if column > 7
        if !board[row][column] || board[row][column].color != color
          out_array.push([row, column])
        end
      end
    end

    out_array
  end
end
