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

    def player_input # this function asks for a player input and then records it in @player_selection

        @player_selection = [] # resets player_selection for new input
        @counter = 0 # resets counter for new player input

        def colour_check(colour)
            if @colours.include? colour
                @player_selection.push(colour)
                @counter += 1
                p @player_selection
            else puts "That's not one of the right colours!" 
            end
        end

        until counter == 4
            if counter == 0
                puts "What colour is the first peg?"
                selected_colour = gets.chomp
                colour_check(selected_colour)
            elsif counter == 1
                puts "What colour is the second peg?"
                selected_colour = gets.chomp
                colour_check(selected_colour)
            elsif counter == 2
                puts "What colour is the third peg?"
                selected_colour = gets.chomp
                colour_check(selected_colour)
            elsif counter == 3
                puts "What colour is the fourth peg?"
                selected_colour = gets.chomp
                colour_check(selected_colour)
            end
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
end

class Game

    include Actions

    attr_accessor :code_pegs, :colours, :counter

    def initialize
        @code_pegs = []
        @player_selection = []
        @counter = 0
        @colours = ['red', 'blue', 'yellow', 'green', 'orange', 'purple']
        @turns = 0 
     
        def play_game
            
            puts "Who is guessing? Computer or Human?"
            who_is_guessing = gets.chomp.downcase
            if who_is_guessing == "computer"
                @code_pegs = player_input
                ## TO CODE INTO HERE THE COMPUTER AI
            elsif who_is_guessing == "human"
                random_input(@code_pegs, @colours)
                until @turns == 12
                    player_input
                    result = check_answers
                    @turns += 1
                    p result
                    if result == ['black', 'black', 'black', 'black']
                        p "You win!"
                        @turns = 12
                    elsif @turns == 11
                        p "You lose! Better luck next time!"
                    end
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