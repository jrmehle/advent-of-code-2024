def find_direction(levels)
  if levels[0] < levels[1]
                  'increasing'
                elsif levels[0] > levels[1]
                  'decreasing'
                else
                  'even'
                end
end

def all_increasing_or_decreasing?(levels)
  direction = find_direction(levels)
  safe_checks = []
  levels.each_with_index do |level, index|
    next_level = levels[index + 1]
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

def differ_by_at_least_one_and_at_most_three?(levels)
  direction = find_direction(levels)
  safe_checks = []
  levels.each_with_index do |level, index|
    next_level = levels[index + 1]
    break if next_level.nil?

    difference_between_levels = (next_level - level).abs
    safe_checks << (difference_between_levels >= 1 && difference_between_levels <= 3)
  end

  safe_checks.all?(true)
end

def safe?(levels)
  all_increasing_or_decreasing?(levels) && differ_by_at_least_one_and_at_most_three?(levels)
end

def dampened_safe?(levels)
  safe_checks = []
  levels.each_with_index do |level, index|
    dampened_levels = levels.dup
    dampened_levels.delete_at(index)
    safe_checks << safe?(dampened_levels)
  end

  safe_checks.any?(true)
end

safe_count = 0
File.readlines('input', chomp: true).each do |report|
  levels = report.split(' ').map(&:to_i)
  direction = find_direction(levels)
  safe = (safe?(levels) || dampened_safe?(levels))
  safe_count += 1 if safe
end

puts "Safe: #{safe_count}"
