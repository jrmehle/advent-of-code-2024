def perform(mul_string)
  operands = mul_string.gsub('mul(', '').gsub(')', '').split(',').map(&:to_i)
  operands[0] * operands[1]
end

corrupted = File.read('input')

# find mul(number, number)
numbers = []
corrupted.scan(%r{mul\(\d+,\d+\)}) do |match|
  numbers << perform(match)
end

puts numbers.sum
