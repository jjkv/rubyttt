require_relative 'board'

class RandomTTT

  def initialize
    @players = [ "X", "O" ]
    @board = Board.theBoard
    @board.add_players(@players)
    @curr_player = @players[rand(0..1)]
    @turn = 0
    @waittime = 1
    @open_space = ->(space) { space.nil? }
  end

  def play
    until done = outcome
      step
    end
    stop(done)
  end

  def outcome
    # YOUR CODE GOES HERE
  end

  def step
    # YOUR CODE GOES HERE
  end

  def stop(result)
    puts "GAME ENDS AFTER " + @turn.to_s + " TURNS!"
    case result
    when "TIE"
      puts "TIE GAME!"
    else
      puts "WINNER: " + result
    end
  end

  def random_move
    moves = @board.pos_moves(@open_space)
    moves[rand(0..moves.length-1)]
  end

  private

  def visualize
    puts "\nTURN: " + @turn.to_s
    puts "It's player " + @curr_player + "'s turn"
    @board.visualize
  end

  def other_player(p)
    @players[~@players.index(p)]
  end

  def wins_on_board?(p)
    pwins = Proc.new { |player| player ? player == p : false }
    @board.for_any_row_col_diag? { |group| group.all? pwins }
  end

end

if __FILE__ == $0
    RandomTTT.new.play
end
