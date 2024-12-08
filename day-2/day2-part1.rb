def all_increasing_or_decreasing?(report, direction)
  levels = report.split(' ').map(&:to_i)

  safe_checks = []
  levels.each_with_index do |level, index|
    next_level = levels[index + 1] unless index + 1 > levels.size
    break if next_level.nil?

    safe_checks << if level == next_level
                     false
                   else
                     case direction
                     when 'increasing'
                       next_level > level
                     when 'decreasing'
                       level > next_level
                     end
                   end
  end

  safe_checks.all?(true)
end

def differ_by_at_least_one_and_at_most_three?(report, direction)
  levels = report.split(' ').map(&:to_i)

  safe_checks = []
  levels.each_with_index do |level, index|
    next_level = levels[index + 1] unless index + 1 > levels.size
    break if next_level.nil?

    difference_between_levels = (next_level - level).abs
    safe_checks << (difference_between_levels >= 1 && difference_between_levels <= 3)
  end

  safe_checks.all?(true)
end

safe_count = 0
File.readlines('input', chomp: true).each do |report|
  levels = report.split(' ').map(&:to_i)
  direction = if levels[0] < levels[1]
                'increasing'
              elsif levels[0] > levels[1]
                'decreasing'
              end

  safe = all_increasing_or_decreasing?(report, direction) && differ_by_at_least_one_and_at_most_three?(report, direction)
  safe_count += 1 if safe
end

puts "Safe: #{safe_count}"
