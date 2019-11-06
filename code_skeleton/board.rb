
# definition of class Board
class Board


  # EXPLANATION OF THE BOARD ABSTRACTION
  # 
  # the board represents 9 "squares". we represent these 9 squares
  # as a 2d array. a square is empty if the value held in the 2d array is
  # nil. a square is not empty if a player occupies that square, meaning
  # a symbol (in our case, either :X or :O).

  # abstractly, we represent squares in two ways, as either a "space" or as
  # a pair of "coordinates":
  #
  # - a space is a string of length two denotating a space on the board. 
  #   for example, the square at position 0,0 on the board is the top left space,
  #   and is thus represented as "TL", the middle center space of the board is "MC", etc.
  #
  # - coordinates are integers specifying the actual indecis of a square in the
  #   2d array. the top left square (i.e. space "TL") has coordinates 0,0
  # 
  # coordinates are used interally, whereas spaces are exposed to the public (i.e. 
  # things outside of the Board class). this is because spaces provide a better
  # abstraction for squares on a board, as they do not reveal anything about
  # the internal representation of the board (namely that it is a 2d array!). 
  # a consequence of this is that public instance methods that deal with the
  # board take and return spaces (make_move, and pos_moves, for instance), but 
  # private instance methods may deal directly with coordinates 
  # (row, space_from_coords, etc.).

  ########################################################################################

  # called everytime a Board object is created using new
  # initializes all instance variables of Board objects
  def initialize
    @players = nil
    @size = 3

    # a 3x3 2d array of squares, each square is initialized to nil
    @board = Array.new(@size) { Array.new(@size) { nil } }

    # maps space substrings to coordinates (e.g. space "TR" == @board[0][2])
    # @row_coord["M"] == 1
    @row_coord = { "T" => 0, "M" => 1, "B" => 2 }
    @col_coord = { "L" => 0, "C" => 1, "R" => 2 }

    # maps coordinates to space substrings (e.g. @row_space[1] == "M")
    @row_space = @row_coord.keys
    @col_space = @col_coord.keys
  end

  # takes an array of players, where each player is a symbol
  def add_players(players) @players = players end

  # given a lambda squarepred : square -> bool, answer an array of SPACES
  # representing all squares (positions i, j) on the board for which 
  # squarepred.call(square) evaluates to true (where square == @board[i][j] for some i, j)
  # yes, lambda objects are called on arguments using the .call method. 
  # argements to the call method should be in parenthesis.
  def pos_moves(squarepred)
    # YOUR CODE GOES HERE
  end

  # given a player and a space string ("TR", "BL", etc.), place the player 
  # on that space. if the player cannot move to the provided space, raise
  # exception "IllegalMove" ( `raise StandardError.new "IllegalMove` )
  # you may find use for the private methods empty? and place, which
  # are both defined for you below.
  def make_move(player, space)
    # YOUR CODE GOES HERE
  end

  # given a lambda linepred : square array -> bool, returns true if the 
  # lambda returns true for any line l, where l is an array of squares on the board.
  #
  # use the following private instance methods to access lines:
  #  - row(i), col(i): returns the ith row/column of the board
  #  - nw_se, sw_ne: these methods return the two diagonals:
  #    - nw_se returns the "north west south east" diagonal (spaces "TL", "MC", "BR")
  #    - sw_ne returns the "south west north east" diagonal (spaces "BL", "MC", "TR")
  #
  # as in the pos_move method, you will need to call linepred using its .call
  # method like so: linepred.call(nw_se) will evaluate linepred on a diagonal line array
  def for_any_row_col_diag?(linepred)
    # YOUR CODE GOES HERE
  end

  # prints a string representation of the board
  def visualize
    delim = "-------------\n"
    s = delim
    @board.each do |row|
      s = row.reduce(s + "|") { |s, space| "#{s} #{space.nil? ? " " : space} |" }
      s = "#{s}\n#{delim}"
    end
    puts s
  end  

  # all instance methods following the keyword private are private
  private

  # the following 4 functions may be used to answer the ith row, col, or 
  # the two diagonals (northwest to southeast and southwest to northeast)

  def row(i) @board[i] end

  def col(j) @board.reduce(Array.new) { |col, row| col << row[j] } end

  def nw_se; (0..@size-1).reduce(Array.new) { |diag, i| diag << @board[i][i] } end

  def sw_ne; (0..@size-1).reduce(Array.new) { |diag, i| diag << @board[@size-1-i][i] } end

  # two methods empty? and place used for interacting with the board directly  

  def empty?(space)
    ij = coords_from_space(space)
    @board[ij[0]][ij[1]].nil?
  end

  def place(player, space)
    ij = coords_from_space(space)
    @board[ij[0]][ij[1]] = player
  end

  # finally, two methods for converting between spaces and coordinates

  def space_from_coords(i, j)
    r = i >= 0 && i < 3 ? @row_space[i] : ""
    c = j >= 0 && j < 3 ? @col_space[j] : ""
    r+c
  end

  def coords_from_space(space)
    if space.length == 2
      return @row_coord[space[0]], @col_coord[space[1]]
    end
  end

end
