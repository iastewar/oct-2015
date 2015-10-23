require 'colorize'
require './piece.rb'

class Horse < Piece
  attr_accessor :number

  def initialize(color, number)
    super(color)
    @number = number
  end

  def to_string
    if color
      "H#{number} ".white
    else
      "H#{number} ".black
    end
  end

  def to_sym
    if color
        return "h#{number}w".to_sym
    else
      return "h#{number}b".to_sym
    end
  end

  # returns an array of possible moves from position parameter (an array with 2 elements) (e.g. [0,0] means piece is at position 0,0)
  def possible_moves(position, board, color)
    out_array = []

    x = position[0]
    y = position[1]

    add_to_move_array(x - 1, y - 2, board, color, out_array)
    add_to_move_array(x - 2, y - 1, board, color, out_array)
    add_to_move_array(x - 2, y + 1, board, color, out_array)
    add_to_move_array(x - 1, y + 2, board, color, out_array)
    add_to_move_array(x + 1, y + 2, board, color, out_array)
    add_to_move_array(x + 2, y + 1, board, color, out_array)
    add_to_move_array(x + 2, y - 1, board, color, out_array)
    add_to_move_array(x + 1, y - 2, board, color, out_array)

    out_array
  end

  private

  def add_to_move_array(x, y, board, color, move_array)
    if x > 7 || x < 0 || y > 7 || y < 0
      false
    elsif !board[x][y] || board[x][y].color != color
      move_array.push([x, y])
      true
    else
      false
    end
  end


end
