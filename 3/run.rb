binary_numbers = STDIN.readlines.map { |s| s.rstrip.chars.map(&:to_i) }

# Part 1
gamma_rate = binary_numbers.transpose.map{ _1.sum > (_1.count / 2) ? 1 : 0 }
epsilon_rate = binary_numbers.transpose.map{ _1.sum < (_1.count / 2) ? 1 : 0 }
puts gamma_rate.join.to_i(2) * epsilon_rate.join.to_i(2)

# Part 2
pos = 0
_binary_numbers = binary_numbers.clone
while _binary_numbers.count > 1 do
    current_bits = _binary_numbers.map{ _1[pos] }
    most_significant_bit = current_bits.count(1) >= current_bits.count(0) ? 1 : 0
    _binary_numbers.select! { _1[pos] == most_significant_bit }
    pos += 1
end
oxygen_generator_rating = _binary_numbers.first.join.to_i(2)
pos = 0
_binary_numbers = binary_numbers.clone
while _binary_numbers.count > 1 do
    current_bits = _binary_numbers.map{ _1[pos] }
    least_significant_bit = current_bits.count(1) < current_bits.count(0) ? 1 : 0
    _binary_numbers.select! { _1[pos] == least_significant_bit }
    pos += 1
end
co2_scrubber_rating = _binary_numbers.first.join.to_i(2)
puts oxygen_generator_rating * co2_scrubber_rating
