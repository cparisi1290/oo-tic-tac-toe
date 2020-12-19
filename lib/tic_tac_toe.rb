require 'pry'
class TicTacToe

    WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board #print what board will look like, interpolating each space from @board array
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} " 
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} " 
        puts"-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} " 
    end

    def input_to_index(user_input)
        @user_input = user_input.to_i-1 #user input converted into index value starting with 0
    end

    def move(input_to_index, token = X) #player can't make move without an input
        @board[input_to_index] = token
    end

    def position_taken?(input_to_index) 
        if @board[input_to_index] == 'X' || @board[input_to_index] == 'O' #is this an empty space or has someone taken it?
            true
        else
            false
        end
    end

    def valid_move?(input_to_index)
        #true if move is valid (present on the game board AND not already filled with a token) false or nil if not
        input_to_index.between?(0, 8) && !position_taken?(input_to_index)
     end

     def turn_count
        #gives an integer that can be even or odd
        count = 0
        @board.each do |space|
            count += 1 if space == "X" || space == "O"
        end
        count
     end

     def current_player
        turn_count % 2 == 0 ? "X" : "O"
     end

     def turn #the entire game play
        puts "Enter number 1-9" #ask for input
        user_input = gets.strip #gets input
        index = input_to_index(user_input) #converts input to index value
        if valid_move?(index) #if index value is valid
            token = current_player #place token for current player
            move(index, token) #shows board with placed token
        else
        turn #restarts turn
        end
        display_board 
     end

     def won?
        WIN_COMBINATIONS.detect do |combo| #iterates over winning combos nested array
            @board[combo[0]] == @board[combo[1]] && #if any winning combos, return those combos
            @board[combo[1]] == @board[combo[2]] &&
            position_taken?(combo[0])
        end
    end

    def full?
        @board.all? {|token| token == "X" || token == "O"}
    end

    def draw?
        !won? && full?
    end

    def over?
        won? || draw?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
    
end

