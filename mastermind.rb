require 'pry'

module Actions

    def random_input(selection, colours) # this function will push 4 random colours into the @code_pegs array
        i = 0
        until i == 4
            random_colour = colours[rand(6)]
            selection.push(random_colour)
            i += 1
        end
        p selection
    end

    def human_input # this function asks for a player input and then records it in either the @code_pegs or the @player_selection bucket

        selection = []

        @counter = 0 # resets counter for new player input

        until counter == 4
            if counter == 0
                puts "What colour is the first peg?"
                selected_colour = gets.chomp
                if @colours.include? selected_colour
                    selection.push(selected_colour)
                    @counter+= 1
                    p selection
                else puts "That's not one of the right colours!"
                end
            elsif counter == 1
                puts "What colour is the second peg?"
                selected_colour = gets.chomp
                if @colours.include? selected_colour
                    selection.push(selected_colour)
                    @counter+= 1
                    p selection
                else puts "That's not one of the right colours!"
                end
            elsif counter == 2
                puts "What colour is the third peg?"
                selected_colour = gets.chomp
                if @colours.include? selected_colour
                    selection.push(selected_colour)
                    @counter+= 1
                    p selection
                else puts "That's not one of the right colours!"
                end
            elsif counter == 3
                puts "What colour is the fourth peg?"
                selected_colour = gets.chomp
                if @colours.include? selected_colour
                    selection.push(selected_colour)
                    @counter+= 1
                    p selection
                else puts "That's not one of the right colours!"
                end
            end
        end

        if @who_is_guessing == 'computer'
            @code_pegs = selection
        elsif @who_is_guessing == 'human'
            @player_selection = selection
        end
    end
        
    def check_answers # checks the answers of the player input against the computer

        result = []

        temp_answer = @code_pegs.clone
        temp_player = @player_selection.clone

        peg_position = 0
        until peg_position == 4
            if temp_answer[peg_position] == temp_player[peg_position]
                result.push('black')
                temp_answer[peg_position] = "correct"
                temp_player[peg_position] = "correct"
            else result.push(' ')
            end 
        peg_position += 1
        end

        peg_position = 0 # resets so now it looks for out of place items
        until peg_position == 4
            if temp_answer[peg_position] == "correct"
                peg_position +=1
            elsif temp_answer.include? temp_player[peg_position]
                result[peg_position] = "white"
                peg_position += 1
            else
                peg_position += 1
            end
        end
        result
    end

    def computer_guess

        temp_previous_answer = @player_selection.clone
        temp_last_result = @last_result.clone
        new_selection = ["", "", "", ""] # empty new selection to be pushed into player selection afterwards

        black_peg_position = 0
        until black_peg_position == 4
            if temp_last_result[black_peg_position] == "black"
                new_selection[black_peg_position] = temp_previous_answer[black_peg_position]
            end
            black_peg_position += 1
        end

        white_peg_position = 0
        until white_peg_position == 4
            if temp_last_result[white_peg_position] == "white"

                # puts the colour that is known to be in the wrong place into the first "empty" spot in the new guess
                sub_peg_position = 0
                until sub_peg_position == 4
                    if new_selection[sub_peg_position] == "" && sub_peg_position != white_peg_position
                        new_selection[sub_peg_position] = temp_previous_answer[white_peg_position]
                        sub_peg_position = 3
                    end
                    sub_peg_position += 1
                end
            end
            white_peg_position +=1
        end

        empty_peg_position = 0
        until empty_peg_position == 4
            if new_selection[empty_peg_position] == ""
                new_selection[empty_peg_position] = @colours[rand(6)]
            end
            empty_peg_position +=1
        end

        @player_selection = new_selection #pushes the new computer guess to @player_selection
        p @player_selection

    end   
end

class Game

    include Actions

    attr_accessor :code_pegs, :player_selection, :counter, :colours, :turns, :last_result, :who_is_guessing

    def initialize
        @code_pegs = []
        @player_selection = []
        @counter = 0
        @colours = ['red', 'blue', 'yellow', 'green', 'orange', 'purple']
        @turns = 0
        @last_result = []
        @who_is_guessing
     
        def play_game
            
            puts "Who is guessing? Computer or Human?"
            @who_is_guessing = gets.chomp.downcase
            
            if @who_is_guessing == "computer"
                human_input
                until @turns == 12
                    computer_guess
                    @last_result = check_answers
                    p @last_result
                    if @last_result == ['black', 'black', 'black', 'black']
                        p "The computer has figured it out! You are no match for the computer"
                        @turns = 11
                    elsif @turns == 11
                        p "The computer couldn't figure out your puzzle!"
                    else
                        p "The computer has not guessed right yet"
                    end
                    @turns += 1
                end
            
            elsif @who_is_guessing == "human"
                random_input(@code_pegs, @colours)
                until @turns == 12
                    human_input
                    @last_result = check_answers
                    p @last_result
                    if @last_result == ['black', 'black', 'black', 'black']
                        p "You win!"
                        @turns = 11
                    elsif @turns == 11
                        p "You lose! Better luck next time!"
                    end
                    @turns += 1
                end
            
            else
                puts "That's not an option, guess again!"
                who_is_guessing = gets.chomp.downcase
            end
        end
    end
end

new_game = Game.new()
new_game.play_game