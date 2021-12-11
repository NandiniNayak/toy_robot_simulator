require 'colorize'
require_relative './lib/simulator.rb'

class App
    def initialize()
        @simulator = Simulator.new()
    end

    def execute
        puts "welcome to the toy simulator app
        Enter following commands
        PLACE X,Y,F -  to place the robot on the table at position x,y and facing direction NORTH|SOUTH|EAST|WEST
        MOVE -  to move the robot in the placed direction
        LEFT - to rotate robot 90 deg left, without changing position
        RIGHT - to rotate robot 90 deg right, without changing position
        REPORT - print robot position
        EXIT - exit the app

        Example: PLACE 0,0,NORTH
            MOVE
            REPORT
        "
        # main loop to run the simulator app unless the command is to exit
        loop do
            command = gets.chomp.strip().downcase()
            break if command == "exit"
            begin
                 puts @simulator.run(command).colorize(:green)
            rescue Exception => e
                puts e.message.colorize(:red)
            end
        end
        puts "Thanks for playing"
    end
end

App.new().execute()

