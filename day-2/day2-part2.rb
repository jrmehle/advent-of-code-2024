def all_increasing_or_decreasing?(levels, direction)
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

def differ_by_at_least_one_and_at_most_three?(levels, direction)
  safe_checks = []
  levels.each_with_index do |level, index|
    next_level = levels[index + 1] unless index + 1 > levels.size
    break if next_level.nil?

    difference_between_levels = (next_level - level).abs
    safe_checks << (difference_between_levels >= 1 && difference_between_levels <= 3)
  end

  safe_checks.all?(true)
end

def pass_dampened_check?(levels, direction)
  safe_checks = []
  puts "*" * 80
  puts "levels for dampening: #{levels.inspect}"
  levels.each do |level|
    dampened_levels = levels - [level]
    puts "dampened_levels: #{dampened_levels.inspect}"

    safe_checks << all_increasing_or_decreasing?(dampened_levels, direction) &&
                   differ_by_at_least_one_and_at_most_three?(dampened_levels, direction)
  end

  puts "dampened safe_checks: #{safe_checks.inspect}"
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

  safe = all_increasing_or_decreasing?(levels, direction) &&
         differ_by_at_least_one_and_at_most_three?(levels, direction) &&
         pass_dampened_check?(levels, direction)
  safe_count += 1 if safe
end

puts "Safe: #{safe_count}"
