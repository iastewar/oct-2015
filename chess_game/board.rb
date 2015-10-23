require 'colorize'
require 'pry'
Dir["./pieces/*.rb"].each do |file|
  require(file)
end


class Board
  attr_accessor :board, :piece_locations

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @piece_locations = Hash.new
    @game_over = false

    # initialize board array and peice_locations hash
    for i in 0...board.length
      @board[1][i] = Pawn.new(false, board.length - i)
      @piece_locations[@board[1][i].to_sym] = [1, i]

      @board[6][i] = Pawn.new(true, i + 1)
      @piece_locations[@board[6][i].to_sym] = [6, i]
    end

    board[0][0] = Rook.new(false, 2)
    @piece_locations[@board[0][0].to_sym] = [0, 0]

    board[0][7] = Rook.new(false, 1)
    @piece_locations[@board[0][7].to_sym] = [0, 7]

    board[7][0] = Rook.new(true, 1)
    @piece_locations[@board[7][0].to_sym] = [7, 0]

    board[7][7] = Rook.new(true, 2)
    @piece_locations[@board[7][7].to_sym] = [7, 7]

    board[0][1] = Horse.new(false, 2)
    @piece_locations[@board[0][1].to_sym] = [0, 1]

    board[0][6] = Horse.new(false, 1)
    @piece_locations[@board[0][6].to_sym] = [0, 6]

    board[7][1] = Horse.new(true, 1)
    @piece_locations[@board[7][1].to_sym] = [7, 1]

    board[7][6] = Horse.new(true, 2)
    @piece_locations[@board[7][6].to_sym] = [7, 6]

    board[0][2] = Bishop.new(false, 2)
    @piece_locations[@board[0][2].to_sym] = [0, 2]

    board[0][5] = Bishop.new(false, 1)
    @piece_locations[@board[0][5].to_sym] = [0, 5]

    board[7][2] = Bishop.new(true, 1)
    @piece_locations[@board[7][2].to_sym] = [7, 2]

    board[7][5] = Bishop.new(true, 2)
    @piece_locations[@board[7][5].to_sym] = [7, 5]

    board[0][3] = King.new(false)
    @piece_locations[@board[0][3].to_sym] = [0, 3]

    board[7][3] = King.new(true)
    @piece_locations[@board[7][3].to_sym] = [7, 3]

    board[0][4] = Queen.new(false)
    @piece_locations[@board[0][4].to_sym] = [0, 4]

    board[7][4] = Queen.new(true)
    @piece_locations[@board[7][4].to_sym] = [7, 4]

  end

  def game_over?
    @game_over
  end

  def display
    letters = ("a".."z").to_a
    print "   "
    for i in 0...board.length
      print "#{i+1}  ".red
    end
    print "\n"
    light = true
    for i in 0...board.length
      print "#{letters[i]}  ".red
      for j in 0...board.length
        if board[i][j].is_a? Piece
          print board[i][j].to_string
        else
          if light
            print " . ".light_yellow
          else
            print " . ".yellow
          end
        end
        light ^= true
      end
      light ^= true
      print "\n"
    end
  end

  # returns false if command is not valid (ie. piece could not be moved)
  def move_piece(color, command) # command example: "P3 4,5"
    command_arr = command.split(" ")
    if command_arr.length != 2
      return false
    end

    # retrive current piece location from hash and get piece from board
    piece_sym = Piece.get_sym(command_arr[0], color)
    location_arr = piece_locations[piece_sym]
    return false unless location_arr
    piece = board[location_arr[0]][location_arr[1]]

    # get location to move piece to into correct format
    end_location_strings = command_arr[1].split(",")
    end_location = end_location_strings.map { |coor_str| coor_str.to_i}
    if end_location.length != 2
      return false
    end
    end_location.each do |coor|
      if coor < 0
        return false
      elsif coor > 7
        return false
      end
    end

    # see if piece can move to end location
    possible_moves_arr = piece.possible_moves(location_arr, board, color)
    return false unless possible_moves_arr.include?(end_location)

    # update board and piece location hash
    board[location_arr[0]][location_arr[1]] = nil
    ending_slot = board[end_location[0]][end_location[1]]
    if ending_slot                 # something already in slot
      @game_over = true if ending_slot.is_a? King
      @winner = color
      piece_locations[ending_slot.to_sym] = nil  # kill the piece already there
    end
    piece_locations[piece_sym] = end_location
    board[end_location[0]][end_location[1]] = piece

    true
  end

  def get_winner
    @winner
  end
end
