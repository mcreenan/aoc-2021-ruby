class Grid
    attr_accessor :cells
    attr_accessor :size

    def initialize(size)
        @size  = size
        @cells = Array.new(size){ Array.new(size, 0) }
    end

    def add_line_segment(x1, y1, x2, y2, diagonal = false)
        return if !diagonal and (x1 != x2 and y1 != y2)
        x_min, x_max = [x1, x2].minmax
        y_min, y_max = [y1, y2].minmax
        x_step = x2 <=> x1
        y_step = y2 <=> y1
        x = x1
        y = y1
        distance = [x_max - x_min, y_max - y_min].max
        (0..distance).each { |d|
            @cells[y][x] += 1
            x += x_step
            y += y_step
        }
    end

    def printme
        (0...@size).each do |y|
            (0...@size).each do |x|
                case @cells[y][x]
                when 0
                    print "."
                else
                    print @cells[y][x]
                end
            end
            puts
        end
    end
end

line_segments = STDIN.readlines.map { |line_segment|
    line_segment.split(' -> ').map{ |coord| coord.split(',').map &:to_i }
}
grid_size = line_segments.flatten.max + 1

# Part 1
part1_grid = Grid.new(grid_size)
line_segments.each do |line_segment|
    part1_grid.add_line_segment(*line_segment.flatten)
end
puts part1_grid.cells.flatten.count{ |cell| cell > 1 }

# Part 2
part2_grid = Grid.new(grid_size)
line_segments.each do |line_segment|
    part2_grid.add_line_segment(*line_segment.flatten, diagonal: true)
end
puts part2_grid.cells.flatten.count{ |cell| cell > 1 }
