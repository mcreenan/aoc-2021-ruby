depths = IO.readlines("input").map(&:rstrip).map(&:to_i)

class Array
    def window(n)
        (self[0...(self.count - (n - 1))].map.with_index do |item, index|
            self[index...(index + n)]
        end).to_a
    end
end

# Part 1
puts (depths.window(2).map do |i1, i2|
    i1 < i2 ? 1 : 0
end).sum

# Part 2
puts (depths.window(3).map(&:sum).window(2).map do |i1, i2|
    i1 < i2 ? 1 : 0
end).sum

