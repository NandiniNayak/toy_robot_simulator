require_relative 'table'
require_relative 'robot'

class Simulator
    def initialize()
        @table = Table.new(5,5)
        @robot = Robot.new(@table)
    end

=begin
validate position datatype to be integer
capture posx,posy and direction from the command
check if place command has 3 arguments passed
=end

    def validate_input(args)
        if args && args.length == 3
            raise TypeError, 'Invalid position type' unless args[0] !~/\D/ and args[1] !~/\D/
            posx = args[0].to_i
            posy = args[1].to_i
            direction = args[2].to_sym  

            return posx, posy, direction
        else
             raise ArgumentError, 'Invalid command: Ensure posx, posy and direction is passed to the place command
            example input : PLACE 0,0,NORTH'
            return false
        end
    end

=begin
run the program based on the command provided
validates  command and raises exception if the input command is not valid
=end

    def run(command)
        input = command.split
        raise ArgumentError, "Invalid command try again" if input.empty?
        case input.first.to_sym
        when :place
            # validate inputs before placing robot on the table
            posx, posy, direction = validate_input(input[1] && input[1].split(","))
            @robot.place(posx, posy, direction)
        when :move
            @robot.current_position.empty? ? (raise ArgumentError, "place command must be run first") : @robot.move
        when :right,:left
            @robot.current_position.empty? ? (raise ArgumentError, "place command must be run first") : @robot.turn(input.first.to_sym)
        when :report
            @robot.current_position.empty? ? (raise ArgumentError, "place command must be run first") : @robot.report
        else
            raise ArgumentError, "Invalid command try again"
        end
    end
end
