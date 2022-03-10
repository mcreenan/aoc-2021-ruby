all_fish = STDIN.read.split(",").map{ |timer| timer.to_i }
empty_fish_counts = (0..8).zip([].fill(0, 0..8)).to_h

# Part 1 AND 2
[80, 256].each do |days|
    fish_counts = empty_fish_counts.merge(all_fish.tally)
    (1..days).each do
        new_fish_count = fish_counts[0]
        fish_counts[0] = fish_counts[1]
        fish_counts[1] = fish_counts[2]
        fish_counts[2] = fish_counts[3]
        fish_counts[3] = fish_counts[4]
        fish_counts[4] = fish_counts[5]
        fish_counts[5] = fish_counts[6]
        fish_counts[6] = fish_counts[7] + new_fish_count
        fish_counts[7] = fish_counts[8]
        fish_counts[8] = new_fish_count
    end
    puts fish_counts.values.sum
end
