require_relative 'board'

# definition of class RandomTTT
# our tic tac toe simulation is executed when the instance method play is invoked. 
class RandomTTT

  # when any object is created, the initialize method is called automatically
  # in other words, initialize is called when we create a RandomTTT instance 
  # using RandomTTT.new
  # @players, @board, @curr_player, etc. are instance variables of RandomTTT
  # instances, and they are private by default (only accessible by the RandomTTT
  # object that holds them)
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
  # the "until loop" invokes the step instance method until the condition is true.
  # our condition (gameover = outcome) is an assignment expression, where the
  # value of the assignment is the value of the local variable gameover after it
  # has been assigned the value returned by calling the instance method outcome.
  # basically, we call the step method until outcome returns something that 
  # evaluates to true, then we call report on that value
  def play
    until gameover = outcome
      step
    end
    report gameover
  end

  # BEFORE IMPLEMENTING outcome, YOU MUST FIRST IMPLEMENT wins_on_board? !!!
  #
  # determines the outcome of the game according to the following:
  #  - if a player wins, return that player as a symbol (either :X or :O)
  #  - if the game is a draw, return the symbol :TIE
  #  - otherwise, the game is not over, return nil
  #
  # to determine the outcome of a game, you may find use for the following
  # instance methods:
  #  - wins_on_board? (private instance method of RandomTTT, you must write this)
  #  - other_player (a private instance method of RandomTTT, defined for you below)
  #  - pos_moves (a public instance method of Board, you must write this in board.rb)
  def outcome
    # YOUR CODE GOES HERE
  end

  # takes a single step of the simulation by performing the following actions:
  #  1. set the current player to the other player
  #  2. have the new current player make a random move
  #  3. increment the turn instance variable
  #  4. print the state of the game
  #  5. sleep for some amount of time
  #
  # you may find use for the following while implementing step:
  #  - other_player (defined below)
  #  - make_move (a public instance method of Board, defined for you in board.rb)
  #  - visualize (a private instance method of RandomTTT, defined for you below)
  #  - sleep (takes an integer n and sleeps for n seconds)
  def step
    # YOUR CODE GOES HERE
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
  # moves returned this way are legal moves for the board.
  # calls the public instance method of @board Board object pos_moves
  # with one argument @open_square
  def random_move
    moves = @board.pos_moves(@open_square)
    moves[rand(0..moves.length-1)]
  end

  private

  # calls the visualize method of the board class on @board
  def visualize
    puts "\nTURN: #{@turn}"
    puts "It's player #{@curr_player}'s turn"
    @board.visualize
  end


  # if p is :X, return :O, else if p is :O, return :X
  # ~ is bitwise negation
  def other_player(p) @players[~@players.index(p)] end

  # takes a player p and answers whether or not p has won the game
  # use the for_any_row_col_diag? method of the board to write
  # this method
  # you will need to pass a lambda object to for_any_row_col_diag?;
  # see the assignment of the @open_square instance variable in this
  # class's initialize method for an example of how to create lambdas
  def wins_on_board?(p)
    # YOUR CODE GOES HERE
  end

end

if __FILE__ == $0
    RandomTTT.new.play
end
