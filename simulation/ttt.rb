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

  # runs the game to completion, this method is invoked at the bottom of the file
  def play
    until gameover = outcome
      step
    end
    report gameover
  end

  # determines the outcome of the game according to the following:
  #  - if a player wins, return that player as a symbol (either :X or :O)
  #  - if the game is a draw, return the symbol :TIE
  #  - otherwise, the game is not over, return nil
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

  # takes a single step of the simulation:
  #  1. set the current player to the other player
  #  2. have the new current player make a random move
  #  3. increment the turn instance variable
  #  4. print the state of the game
  #  5. sleep for some amount of time
  def step
    @curr_player = other_player @curr_player
    @board.make_move(@curr_player, random_move)
    @turn += 1
    visualize
    sleep @waittime
  end

  # takes the result of the game (tie, or win) and reports the outcome
  # raises an exception if result is nil 
  def report(result)
    puts "GAME ENDS AFTER #{@turn} TURNS!"
    case result
    when :TIE
      puts "TIE GAME!"
    when nil
      raise StandardError.new "Impossible State"
    else
      puts "WINNER: #{result}"
    end
  end

  # returns a single move as a space ("TR", "BL", etc.)
  # moves returned this way are legal moves for the board
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

  # takes a player p and answers whether or not p has won the game
  # use the for_any_row_col_diag? method of the board to write
  # this method
  def wins_on_board?(p)
    p_on_square = lambda { |player| player ? player == p : false }
    p_wins_line = lambda { |line| line.all? p_on_square }
    @board.for_any_row_col_diag? p_wins_line
  end

end

if __FILE__ == $0
    RandomTTT.new.play
end
