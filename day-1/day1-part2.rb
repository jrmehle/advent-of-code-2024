# read input file and organize data into columns
left_col = []
right_col = []

File.readlines('../input', chomp: true).each do |line|
  left, right = line.split
  left_col << left
  right_col << right
end

total = 0
right_tallies = right_col.tally
# iterate over left list
left_col.each do |left_val|
  # count times item appears in right list
  # multiply number by count and add to total
  right_count = right_tallies[left_val] || 0
  total += left_val.to_i * right_count
end

# output total
puts total
