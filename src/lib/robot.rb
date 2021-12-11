class Robot
    attr_accessor :current_position
    VALID_TURN = {:left => {north: :west, south: :east, east: :north,west: :south}, :right => {north: :east, south: :west, east: :south, west: :north}}
    DIRECTIONS = [:north, :south, :east, :west]

    def initialize(table)
        raise TypeError, 'Invalid table' if table.nil?
        @table  = table
        @current_position = {}
    end

    def place(posx,posy,direction)
        raise TypeError, 'Invalid direction' unless DIRECTIONS.include?(direction)

        # update current position of the robot only if it is valid point on the table
        if (0..@table.rows).include?(posx) && (0..@table.columns).include?(posy)
            current_position[:posx] = posx
            current_position[:posy] = posy
            current_position[:direction] = direction
            return "done"
        else
            raise IndexError, "choose index between 0..#{(@table.rows)-1}"
        end
    end

    def move()
        case current_position[:direction]
        when :north
            # can move north only if not in the last column
             (current_position[:posy] != (@table.columns-1)) ?  current_position[:posy]+= 1  : (raise TypeError, "invalid move turn right to move")
        when :south
            # can move south only if not in the first column
             (current_position[:posy] != 0 ) ? current_position[:posy]-= 1 : (raise TypeError, "invalid move turn left to move")
        when :east
             # can move east only if not in the last row
            (current_position[:posx] != (@table.rows-1)) ? current_position[:posx]+= 1 : (raise TypeError, "invalid move turn left to move")
        when :west
             # can move west only if not in the first row
            (current_position[:posx] != 0) ? current_position[:posx]-= 1 : (raise TypeError, "invalid move turn right to move")
        end
        return "done"
    end

    def turn(input)
        VALID_TURN.each do |command, dir|
            if input == command
                dir.each do |key,val|
                    if key == current_position[:direction]
                        current_position[:direction] = val
                        break
                    end
                 end
                break
            end
        end
        return "done"
    end

    def report
        "#{current_position[:posx]},#{current_position[:posy]},#{current_position[:direction].upcase}"
    end
end