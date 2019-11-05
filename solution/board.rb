class TTTBoard

  def initialize(players = [ "X", "O" ])
    @players = players
    @size = 3
    @board = Array.new(@size) { Array.new(@size) { nil } }
    @row_coord = { "T" => 0, "M" => 1, "B" => 2 }
    @col_coord = { "L" => 0, "C" => 1, "R" => 2 }
    @row_space = @row_coord.keys
    @col_space = @col_coord.keys
    @players = players
  end

  @@theBoard = TTTBoard.new

  private_class_method :new

  def self.theBoard
    return @@theBoard
  end

  def pos_moves
    empty = Array.new
    @board.each_with_index do |row, i|
      row.each_with_index do |space, j|
        if space.nil?
          empty << space_from_coords(i, j)
        end
      end
    end
    empty
  end

  def make_move(player, space)
    if @players.include? player and legal_move? space
      place(player, space)      
    else
      raise StandardError.new "IllegalMove"
    end
  end

  def for_any_row_col_diag?(&proc)
     diag_res = proc.call(nw_se) || proc.call(sw_ne) || false
     (0..@size-1).reduce(diag_res) { |res, i| res || proc.call(row(i)) || proc.call(col(i)) }
  end

  def visualize
    delim = "-------------\n"
    s = delim
    @board.each do |row|
      s = row.reduce(s + "|") { |s, space| s + (space.nil? ? "   |": " " + space + " |") }
      s += "\n" + delim
    end
    puts s
  end
  

  private

  def row(i)
    @board[i]
  end

  def col(j)
    @board.reduce(Array.new) { |col, row| col << row[j] }
  end

  def nw_se
    (0..@size-1).reduce(Array.new) { |diag, i| diag << @board[i][i] }
  end

  def sw_ne
    (0..@size-1).reduce(Array.new) { |diag, i| diag << @board[@size-1-i][i] }
  end
  
  def legal_move?(space)
    ij = coords_from_space(space)
    @board[ij[0]][ij[1]].nil?
  end

  def place(player, space)
    ij = coords_from_space(space)
    @board[ij[0]][ij[1]] = player
  end

  def space_from_coords(i, j)
    r = i >= 0 && i < 3 ? @row_space[i] : ""
    c = j >= 0 && j < 3 ? @col_space[j] : ""
    r+c
  end

  def coords_from_space(space)
    if space.length < 3 
      return @row_coord[space[0]], @col_coord[space[1]]
    end
  end

end

