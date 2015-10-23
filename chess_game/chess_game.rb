require './board.rb'
require 'pry'

require './player.rb'

def command_list
  "Command list:
  1. '[Piece] [Coordinate]', ie. 'Ab c,d' - moves piece Ab to position c,d
  where A is either P, R, H, B, K, or Q and b, c, and d are digits
  2. 'display' - prints the current board state to the screen
  3. 'help' - shows the list of commands
  4. 'new' - ends the game and starts a new game
  5. 'exit' - exits the game"
end

# returns true if method processes a command
def process_command(command, board)

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

def main
  while true
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
        puts "#{player1.name}, please enter a command (type 'help' for command list):" # eg. "P3 4,5"
        command = gets.chomp

        next if process_command(command, board)
        break if command == "new"

        move_successful = board.move_piece(player1_turn, command)
        if !move_successful
          puts "invalid command!"
          next
        end

        board.display

        player1_turn ^= true
      else
        puts "#{player2.name}, please enter a command (type 'help' for command list):"
        command = gets.chomp

        next if process_command(command, board)
        break if command == "new"

        move_successful = board.move_piece(player1_turn, command)
        if !move_successful
          puts "invalid command!"
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
