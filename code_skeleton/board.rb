class Board

  # called everytime a Board object is created using new
  # initializes all instance variables of Board objects
  def initialize
    @players = Array.new
    @size = 3

    # a 3x3 2d array of squares, each square is initialized to nil
    @board = Array.new(@size) { Array.new(@size) { nil } }

    # maps space symbols to coordinates (e.g. space "TR" == @board[0][2])
    @row_coord = { "T" => 0, "M" => 1, "B" => 2 }
    @col_coord = { "L" => 0, "C" => 1, "R" => 2 }

    # maps coordinates to space symbols
    @row_space = @row_coord.keys
    @col_space = @col_coord.keys
  end

  # takes an array of players, where each player is a symbol
  def add_players(players) @players = players end

  # given a lambda squarepred : square -> bool, answer an array of spaces 
  # representing all the positions i, j on the board for which 
  # squarepred(@board[i][j]) evaluates to true
  def pos_moves(squarepred)
    # YOUR CODE GOES HERE
  end

  # given a player and a space string ("TR", "BL", etc.), place the player 
  # on that space. if the player cannot move to the provided space, raise
  # exception "IllegalMove"
  def make_move(player, space)
    # YOUR CODE GOES HERE
  end

  # given a lambda linepred : square array -> bool, returns true if the 
  # lambda returns true for any line l, where l is an array of squares on the board
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