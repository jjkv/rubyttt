# Comp105 Recitation: Tic Tac Toe Simulation

In this directory you will find two files: 

 1. `ttt.rb` contains the definition of class `RandomTTT`, which
    simulates a random game of Tic Tac Toe to completion.

 2. `board.rb` contain the definition of class `Board`, which
    represents a 3x3 board on which many different games can be played,
    including Tic Tac Toe!

You can run the simulation with `ruby ttt.rb`

Once you've got it working, you should see something like this:

```
TURN: 1
It's player X's turn
-------------
|   |   |   |
-------------
| X |   |   |
-------------
|   |   |   |
-------------

TURN: 2
It's player O's turn
-------------
|   | O |   |
-------------
| X |   |   |
-------------
|   |   |   |
-------------

TURN: 3
It's player X's turn
-------------
|   | O |   |
-------------
| X |   |   |
-------------
|   |   | X |
-------------

TURN: 4
It's player O's turn
-------------
|   | O |   |
-------------
| X |   |   |
-------------
|   | O | X |
-------------

TURN: 5
It's player X's turn
-------------
|   | O |   |
-------------
| X |   |   |
-------------
| X | O | X |
-------------

TURN: 6
It's player O's turn
-------------
|   | O | O |
-------------
| X |   |   |
-------------
| X | O | X |
-------------

TURN: 7
It's player X's turn
-------------
| X | O | O |
-------------
| X |   |   |
-------------
| X | O | X |
-------------
GAME ENDS AFTER 7 TURNS!
WINNER: X
```

------------------------------------------------------------------------------

Many methods of these classes have already been defined for you, but some
have not. Your task is to complete the definitions of both classes in order to 
produce a working Tic Tac Toe simulator. You will do this by implementing the 
following classes:

 - `RandomTTT` represents the random Tic Tac Toe simulator. Each instance of
   this class can simulate a single random game of Tic Tac Toe.

 - `Board` represents a 3x3 game board. An instance of the board class may
   be used to play Tic Tac Toe, but could be used for other games that require
   a 3x3 board as well.

IMPLEMENT THE `Board` class BEFORE implementing `RandomTTT`!!! You will
implement both classes by completing the definitions of a number of public 
and private methods, which are summarized below. 

The `Board` class implements the following instance methods as its public protocol:

 - `new`: allocates and initializes a new object instance of `Board`. Each
   square on the board is initialized to `nil`. 

 - `add_players`: takes as an argument an array of players (represented as symbols),
   tells the board what players are allowed to make moves on the board.

 - `pos_moves`: this method takes as an argument a lambda object `squarepred`, which
   takes a square and returns true or false whether or not it is possible for a player
   to move to that square. `pos_moves` uses this function to determine which squares
   are possible to move to, and returns the spaces that represent each square as an
   array of strings (this is explained further in board.rb).

 - `make_move`: takes a player and a space as an argument, and updates the board
   by moving the player onto the space. if the argument combination of player and
   space is for some reason impossible, `make_move` raises exception IllegalMove.

 - `for_any_row_col_diag?` takes a lambda `linepred`, which takes a line (a row,
   column, or diagonal on the board, represented as an array of squares) and
   returns true or false. `for_any_row_col_diag?` answers true if `linepred` 
   returns true on *any* line on the board, false otherwise (this is explained further
   in board.rb).

 - `visualize`: prints the state of the board to stdout.

Your first task is to implement `make_move`, `pos_moves` and `for_any_row_col_diag?`.
We recommend implementing these methods in ^that order. 

To test your `Board` class, we have also included a public instance method `test`
partially defined on `Board`. On the command line, if you type `ruby board.rb`, 
the `test` method will be invoked automatically on a newly initialized Board object.

---------------------------------------------------------------------------------

AFTER implementing the `Board` class, you will implement `RandomTTT`. 

The `RandomTTT` class implements the following instance methods as its public
protocol:

 - `new`: allocates and initializes a new object instance of `RandomTTT`. 

 - `play`: simulates a single random game of Tic Tac Toe.

These methods are either inhereted from a super class or implemented for you,
but to complete the definition of `RandomTTT` you will need to implement a number
of *private* methods:

 - `outcome`: answers with the outcome of the game at the time of invocation. 
   the possible outcomes of a game of random Tic Tac Toe are:

   - a player has won the game, in which case the game is over.
   - neither player has won the game, in which case the game is a tie.
   - the game is not over.

 - `step`: simulates a single random turn of Tic Tac Toe.

 - `wins_on_board?`: this method takes a player as an argument and answers true
   or false whether or not that player has won the game according to the 
   current game state. this method is used to implement `outcome`, so it is
   responsible for implementing the logic of winning a game of Tic Tac Toe. 
   the `outcome` method should call `wins_on_board?` to help determine the 
   outcome of a game.
  
There are many more private methods on both classes that defined for you; these
methods are explained in ttt.rb and board.rb. Once you think you have a working
simulation, you can see it in action with the following command:

   `ruby ttt.rb`

