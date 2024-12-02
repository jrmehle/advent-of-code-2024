# read input file and organize data into columns
left_col = []
right_col = []

File.readlines('input', chomp: true).each do |line|
  left, right = line.split
  left_col << left
  right_col << right
end

# sort columns
left_col.sort!
right_col.sort!

# find distances
total_distance = 0
left_col.each_with_index do |val, index|
  left_val = val.to_i
  right_val = right_col[index].to_i
  distance = (left_val - right_val).abs

  # add em up
  total_distance += distance
end

# output
puts total_distance
