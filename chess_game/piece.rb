class Piece
  attr_accessor :color

  def initialize(color) # true is white, false is black
    @color = color

  end

  # piece must be a correctly formated string (eg. "p2" for pawn 2),
  # color is true or false
  # returns the piece as a symbol or nil if no such symbol can exist
  def self.get_sym(piece, color)
    piece_arr = piece.split(//)
    return nil unless piece_arr.length <= 2
    piece_name = piece_arr[0].downcase
    piece_num = piece_arr[1].to_i
    name_arr = %w(b h k p q r)

    case piece_name
    when "b"
      return nil unless (1..4).include?(piece_num)
      return Bishop.new(color, piece_num).to_sym
    when "h"
      return nil unless (1..4).include?(piece_num)
      return Horse.new(color, piece_num).to_sym
    when "k"
      return King.new(color).to_sym
    when "p"
      return nil unless (1..8).include?(piece_num)
      return Pawn.new(color, piece_num).to_sym
    when "q"
      return Queen.new(color).to_sym
    when "r"
      return nil unless (1..4).include?(piece_num)
      return Rook.new(color, piece_num).to_sym
    else
      return nil
    end

  end

end
