require './board.rb'
require 'pry'

require './player.rb'

def command_list
  "Command list:
  1. '[Piece] [Coordinate]' - moves the piece to the specified coordinate (e.g. P5 e,5)
  2. 'display' - prints the current board state to the screen
  3. 'help' - shows the list of commands
  4. 'new' - ends the game and starts a new game
  5. 'exit' - exits the game"
end

# returns true if method processes a command
def process_simple_command(command, board)

  case command
  when "help"
    puts command_list
    return true
  when "display"
    board.display
    return true
  when "exit"
    abort
  end

  false
end

# converts a command like 'P1 D,5' to 'p1 3,4' using a letter_number hash
def process_command(command, letter_number)
  command = command.downcase
  command_arr = command.split("")
  if command_arr.length == 6
    num = letter_number[command_arr[3]]
    return nil unless num
    command_arr[3] = num

    num = command_arr[5].to_i
    return nil unless num
    command_arr[5] = num - 1
  elsif command_arr.length == 5
    num = letter_number[command_arr[2]]
    return nil unless num
    command_arr[2] = num

    num = command_arr[4].to_i
    return nil unless num
    command_arr[4] = num - 1
  else
    return nil
  end

  command = command_arr.join
end

# returns a hash where 'a' is mapped to 0, 'b' to 1, etc.
def create_letter_to_number_hash
  letters = ("a".."z")
  letter_number = Hash.new
  count = 0
  letters.each do |letter|
    letter_number[letter] = count
    count += 1
  end

  letter_number
end

def main
  while true
    letter_number = create_letter_to_number_hash

    puts "Enter name for player 1 (white): "
    player1_name = gets.chomp
    puts "Enter name for player 2 (black): "
    player2_name = gets.chomp

    player1 = Player.new(player1_name)
    player2 = Player.new(player2_name)

    #    binding.pry
    board = Board.new
    board.display


    player1_turn = true # true for white, false for black

    while !board.game_over?
      if player1_turn
        puts "#{player1.name}, please enter a command (type 'help' for command list):" # eg. "P3 D,5"
        command = gets.chomp

        next if process_simple_command(command, board)
        break if command == "new"

        command = process_command(command, letter_number)
        if !command
          puts "Invalid command!"
          next
        end

        move_successful = board.move_piece(player1_turn, command)
        if !move_successful
          puts "That move is illegal!"
          next
        end

        board.display

        player1_turn ^= true
      else
        puts "#{player2.name}, please enter a command (type 'help' for command list):"
        command = gets.chomp

        next if process_simple_command(command, board)
        break if command == "new"

        command = process_command(command, letter_number)
        if !command
          puts "Invalid command!"
          next
        end

        move_successful = board.move_piece(player1_turn, command)
        if !move_successful
          puts "That move is illegal!"
          next
        end

        board.display

        player1_turn ^= true
      end
    end

    if board.game_over?
      winner = ""
      if board.get_winner
        winner = player1.name
      else
        winner = player2.name
      end
      puts "#{winner} won the game!"
    end

  end

end

main
