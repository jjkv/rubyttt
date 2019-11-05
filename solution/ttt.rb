require_relative 'board'

class RandomTTT

  def initialize
    @players = [ "X", "O" ]
    @board = TTTBoard.theBoard
    @current_player = @players[rand(0..1)]
    @turn = 0
    @waittime = 1
  end

  def play
    until done = outcome
      step
    end
    stop(done)
  end

  def outcome
    if wins_on_board?(@current_player)
      @current_player
    elsif wins_on_board?(other_player @current_player)
      other_player @current_player
    elsif @board.pos_moves.length == 0
      "TIE"
    else
      nil
    end
  end

  def step
    @current_player = other_player @current_player
    @board.make_move(@current_player, random_move)
    @turn += 1
    visualize
    sleep(@waittime)
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
    pos_moves = @board.pos_moves
    pos_moves[rand(0..pos_moves.length-1)]
  end

  private

  def visualize
    puts "\nTURN: " + @turn.to_s
    puts "It's player " + @current_player + "'s turn"
    @board.visualize
  end

  def other_player(p)
    @players[~@players.index(p)]
  end

  def wins_on_board?(p)
    pwins = proc { |player| player ? player == p : false }
    @board.for_any_row_col_diag? { |group| group.all? pwins }
  end

end

if __FILE__ == $0
    RandomTTT.new.play
end
