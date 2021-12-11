class Table
    attr_reader :rows, :columns, :table
    def initialize(rows, columns)
        raise TypeError, 'Invalid rows or columns value' unless rows.is_a? Integer and columns.is_a? Integer
        @rows = rows
        @columns = columns
    end
end