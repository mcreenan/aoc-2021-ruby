positions = STDIN.read.split(',').map(&:to_i)

# Part 1
puts (1..positions.max).map { |target_position|
    positions.map{ |position| (target_position - position).abs }.sum
}.min

# Part 2
puts (1..positions.max).map { |target_position|
    positions.map{ |position| d = (target_position - position).abs and (d.to_f / 2) * (1 + d) }.sum.to_i
}.min
