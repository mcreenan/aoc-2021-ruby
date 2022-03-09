commands = STDIN.readlines.map { |c| c.split }

# Part 1
x_pos = 0
depth = 0
commands.each do |command, n|
    case command
    when "forward"
        x_pos += n.to_i
    when "down"
        depth += n.to_i
    when "up"
        depth -= n.to_i
    end
end
puts x_pos * depth


# Part 2
x_pos = 0
depth = 0
aim = 0
commands.each do |command, n|
    case command
    when "forward"
        x_pos += n.to_i
        depth += n.to_i * aim
    when "down"
        aim += n.to_i
    when "up"
        aim -= n.to_i
    end
end
puts x_pos * depth
