class BingoBoard
    attr_accessor :board_numbers
    attr_accessor :board_id

    def initialize(board_numbers, board_id)
        @board_numbers = board_numbers
        @board_id = board_id
    end

    def wins?(selected_numbers)
        board_mask = @board_numbers.map { |row|
            row.map { |cell_number| !!selected_numbers.include?(cell_number) }
        }

        # Horizontal wins
        return true if board_mask.any? { |row| row.all? }

        # Vertical wins
        return true if board_mask.transpose.any? { |row| row.all? }
    end
end

def part1(selected_numbers, boards)
    (1..selected_numbers.count).each do |number_index|
        numbers_to_check = selected_numbers[0...number_index]
        (0...boards.count).each do |board_id|
            if boards[board_id].wins?(numbers_to_check)
                unmarked_numbers = boards[board_id].board_numbers.flatten.select { |n| !numbers_to_check.include?(n) }
                return unmarked_numbers.sum * numbers_to_check.last
            end
        end
    end
    return nil
end


def part2(selected_numbers, boards)
    (1..selected_numbers.count).each do |number_index|
        numbers_to_check = selected_numbers[0...number_index]
        boards.select.with_index do |board, board_id|
            if board.wins?(numbers_to_check)
                if boards.count == 1
                    unmarked_numbers = boards[0].board_numbers.flatten.select { |n| !numbers_to_check.include?(n) }
                    return unmarked_numbers.sum * numbers_to_check.last
                end
                boards.delete_at board_id
            end
        end
    end
    return nil
end


lines = STDIN.readlines(chomp: true)
selected_numbers = lines.shift.split(',').map(&:to_i)
board_count = lines.count / 6
boards = []
(0...board_count).each do |board_id|
    lines_offset = board_id * 6
    boards << BingoBoard.new([lines[lines_offset + 1].split.map(&:to_i),
                              lines[lines_offset + 2].split.map(&:to_i),
                              lines[lines_offset + 3].split.map(&:to_i),
                              lines[lines_offset + 4].split.map(&:to_i),
                              lines[lines_offset + 5].split.map(&:to_i)], board_id)
end

# Part1
puts part1(selected_numbers, boards)

# Part 2
puts part2(selected_numbers, boards)
