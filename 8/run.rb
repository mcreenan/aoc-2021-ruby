entries = STDIN.readlines(chomp: true).map { |entry|
    signal_patterns, output_value = entry.split(' | ')
    {
        signal_patterns: signal_patterns.split.map{ _1.chars.sort.join },
        output_value: output_value.split.map{ _1.chars.sort.join },
    }
}

# Part 1
puts entries.map { |entry|
    entry[:output_value].select{ |digit_segments| [2, 3, 4, 7].include?(digit_segments.length) }.length
}.sum

# Part 2
puts entries.map { |entry|
    signal_pattern_map = entry[:signal_patterns].zip(Array.new(10)).to_h

    # First, map the patterns where we know the mapping based on the number of characters in the pattern
    entry[:signal_patterns].each do |signal_pattern|
        case signal_pattern.length
        when 2
            signal_pattern_map[signal_pattern] = 1
        when 3
            signal_pattern_map[signal_pattern] = 7
        when 4
            signal_pattern_map[signal_pattern] = 4
        when 7
            signal_pattern_map[signal_pattern] = 8
        end
    end

    five_segment_patterns = entry[:signal_patterns].select{ _1.length == 5 }.map{ _1.chars.sort }
    # us=unique segments, meaning the segment patterns where only it has that segment present
    five_sp_us = [
        five_segment_patterns[0] - five_segment_patterns[1] - five_segment_patterns[2],
        five_segment_patterns[1] - five_segment_patterns[0] - five_segment_patterns[2],
        five_segment_patterns[2] - five_segment_patterns[0] - five_segment_patterns[1],
    ]
    six_segment_patterns = entry[:signal_patterns].select{ _1.length == 6 }.map{ _1.chars.sort }
    # only missing, meaning the segment patterns where only it has that segment missing
    six_sp_om = [
        six_segment_patterns[1] & six_segment_patterns[2] - six_segment_patterns[0],
        six_segment_patterns[0] & six_segment_patterns[2] - six_segment_patterns[1],
        six_segment_patterns[0] & six_segment_patterns[1] - six_segment_patterns[2],
    ]

    # Figure out the mapping for 2 by looking for the 5-segment patterns with a unique segment where only 2 of the 3
    # 6-segment patterns have that segment
    (0..2).each do |i|
        if five_sp_us[i].length == 1 and six_segment_patterns.select{ _1.include?(five_sp_us[i].first) }.length == 2
            signal_pattern_map[five_segment_patterns[i].join] = 2
        end
    end

    # Figure out the mapping for 3 by comparing it to the other five-segment patterns (2 and 5)
    # 2 has one segment which neither 3 nor 5 have
    # 5 has one segment which neither 2 nor 3 have
    # 3 has no segments which 2 and 5 do not have
    (0..2).each do |i|
        if five_sp_us[i].length == 0
            signal_pattern_map[five_segment_patterns[i].join] = 3
        end
    end

    # Figure out the mapping for 5 by looking for the 5-segment patterns with a unique segment where all 6-segment
    # patterns have that segment present
    (0..2).each do |i|
        if five_sp_us[i].length == 1 and six_segment_patterns.select{ _1.include?(five_sp_us[i].first) }.length == 3
            signal_pattern_map[five_segment_patterns[i].join] = 5
        end
    end

    # Figure out the mapping for 0, 6, and 9 by looking for the 6-segment patterns that don't have a segment where all
    # 5-segment patterns do have that segment present
    {
        0 => 3,
        6 => 2,
        9 => 1,
    }.each do |digit, required_segments|
        (0..2).each do |i|
            if five_segment_patterns.select{ _1.include?(six_sp_om[i].first) }.length == required_segments
                signal_pattern_map[six_segment_patterns[i].join] = digit
            end
        end
    end

    entry[:output_value].map{ |sp| signal_pattern_map[sp] or "." }.join.to_i
}.sum
