require 'colorize'
require './piece.rb'

class Bishop < Piece
  attr_accessor :number

  def initialize(color, number)
    super(color)
    @number = number
  end

  def to_string
    if color
      "B#{number} ".white
    else
      "B#{number} ".black
    end
  end

  def to_sym
    if color
        return "b#{number}w".to_sym
    else
      return "b#{number}b".to_sym
    end
  end

  # returns an array of possible moves from position parameter (an array with 2 elements) (e.g. [0,0] means piece is at position 0,0)
  def possible_moves(position, board, color)
    out_array = []

    x = position[0]
    y = position[1]
    #going right-down
    while x < 7 && y < 7
      x += 1
      y += 1
      if board[x][y] && board[x][y].color != color
        out_array.push([x, y])
        break
      elsif board[x][y] && board[x][y].color == color
        break
      end
      out_array.push([x, y])
    end

    x = position[0]
    y = position[1]
    while x < 7 && y > 0
      x += 1
      y -= 1
      if board[x][y] && board[x][y].color != color
        out_array.push([x, y])
        break
      elsif board[x][y] && board[x][y].color == color
        break
      end
      out_array.push([x, y])
    end

  #      binding.pry

    x = position[0]
    y = position[1]
    while x > 0 && y < 7
      x -= 1
      y += 1
      if board[x][y] && board[x][y].color != color
        out_array.push([x, y])
        break
      elsif board[x][y] && board[x][y].color == color
        break
      end
      out_array.push([x, y])
    end

    x = position[0]
    y = position[1]
    while x > 0 && y > 0
      x -= 1
      y -= 1
      if board[x][y] && board[x][y].color != color
        out_array.push([x, y])
        break
      elsif board[x][y] && board[x][y].color == color
        break
      end
      out_array.push([x, y])
    end


    out_array
  end
end
