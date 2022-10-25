require 'pry'

class TicTacToe

    def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end
    
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(player_input)
        player_input.to_i - 1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(desired_position)
        @board[desired_position] != " "
    end

    def valid_move?(move_valid)
        !position_taken?(move_valid) && (0..8).include?(move_valid)
    end

    def turn_count
        @board.count do |move|
            move != " "
        end
    end

    def current_player
        if turn_count % 2 == 0
            "X"
        else
            "O"
        end
    end

    def turn
        puts "Place your move and it should be between 1-9"
        user_move = gets.chomp
        index = input_to_index(user_move)
        if valid_move?(index)
            new_player = current_player
            move(index, new_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |random|
            if position_taken?(random[0])
                if @board[random[0]] == @board[random[1]] && @board[random[1]] == @board[random[2]]
                    return random
                end
            end
        end
    end


    def full?
        !@board.include? " "
    end

    def draw?
        full? && !won?
    end

    def over?
        full? || won?
    end

    def winner
        if won?
            combination_win = won?
            @board[combination_win[0]]
        end
    end

    def play
        until over? do
            turn
            if draw?
                return
            end
        end
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end