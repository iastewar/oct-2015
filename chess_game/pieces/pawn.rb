require 'colorize'
require './piece.rb'

class Pawn < Piece
  attr_accessor :number

  def initialize(color, number)
    super(color)
    @number = number
  end

  def to_string
    if color
      "P#{number} ".white
    else
      "P#{number} ".black
    end
  end

  def to_sym
    if color
        return "p#{number}w".to_sym
    else
      return "p#{number}b".to_sym
    end
  end

  # returns an array of possible moves from position parameter (an array with 2 elements) (e.g. [0,0] means piece is at position 0,0)
  def possible_moves(position, board, color)
    out_array = []

    x = position[0]
    y = position[1]

    if color # can only move up
      if x > 0 && !board[x-1][y]
        out_array.push([x-1, y])
      end
      if x == 6 && !board[x-2][y]
        out_array.push([x-2, y])
      end
      if x > 0 && y > 0 && board[x-1][y-1] && board[x-1][y-1].color != color
        out_array.push([x-1, y-1])
      end
      if x > 0 && y < 7 && board[x-1][y+1] && board[x-1][y+1].color != color
        out_array.push([x-1, y+1])
      end

    else     # can only move down
      if x < 7 && !board[x+1][y]
        out_array.push([x+1, y])
      end
      if x == 1 && !board[x+2][y]
        out_array.push([x+2, y])
      end
      if x < 7 && y > 0 && board[x+1][y-1] && board[x+1][y-1].color != color
        out_array.push([x+1, y-1])
      end
      if x < 7 && y < 7 && board[x+1][y+1] && board[x+1][y+1].color != color
        out_array.push([x+1, y+1])
      end
    end

    out_array
  end
end
