def perform(mul_string)
  operands = mul_string.gsub('mul(', '').gsub(')', '').split(',').map(&:to_i)
  operands[0] * operands[1]
end

corrupted = File.read('input')

numbers = []
corrupted.split('do()').each do |token|
  enabled_token = token.split("don't()").first

  enabled_token.scan(%r{mul\(\d+,\d+\)}) do |match|
    numbers << perform(match)
  end
end

puts numbers.sum
