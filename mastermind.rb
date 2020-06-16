require 'pry'


module Actions

    def random_input(selection, colours)
        i = 0
        until i == 4
            random_colour = colours[rand(6)]
            selection.push(random_colour)
            i += 1
        end
        p selection
    end

    def player_input

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
            else check_answers(@code_pegs, @player_selection)
            end
        end

    end
        
    def check_answers(answer, player_answers)
    end

    def play_turn(answer, input)
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
        random_input(@code_pegs, @colours)
        play_turn(@code_pegs, player_input)
    end

    @@turns = 0 # to code into, only 12 turns allowed

end

new_game = Game.new()