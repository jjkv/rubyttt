require_relative 'board'

class RandomTTT

  def initialize
    @players = [ :X, :O ]
    @board = Board.new
    @board.add_players @players
    @curr_player = @players[rand(0..1)]
    @turn = 0
    @waittime = 1
    @open_square = lambda { |square| square.nil? }
  end

  def play
    until done = outcome
      step
    end
    stop done
  end

  def outcome
    if wins_on_board? @curr_player
      @curr_player
    elsif wins_on_board?(other_player @curr_player)
      other_player @curr_player
    elsif @board.pos_moves(@open_square).length == 0
      :TIE
    else
      nil
    end
  end

  def step
    @curr_player = other_player @curr_player
    @board.make_move(@curr_player, random_move)
    @turn += 1
    visualize
    sleep @waittime
  end

  def stop(result)
    puts "GAME ENDS AFTER #{@turn} TURNS!"
    case result
    when :TIE
      puts "TIE GAME!"
    else
      puts "WINNER: #{result}"
    end
  end
  
  def random_move
    moves = @board.pos_moves(@open_square)
    moves[rand(0..moves.length-1)]
  end

  private

  def visualize
    puts "\nTURN: #{@turn}"
    puts "It's player #{@curr_player}'s turn"
    @board.visualize
  end

  def other_player(p) @players[~@players.index(p)] end

  def wins_on_board?(p)
    is_p      = lambda { |player| player ? player == p : false }
    p_wins_on = lambda { |line| line.all? is_p }
    @board.for_any_row_col_diag? p_wins_on
  end

end

if __FILE__ == $0
    RandomTTT.new.play
end
