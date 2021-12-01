file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

increases = 0
sum = input[0] + input[1] + input[2]

input.each_with_index do |num, index|
  next if (0..2).include?(index)
  new_sum = input[index] + input[index - 1] + input[index - 2]
  increases += 1 if new_sum > sum
  sum = new_sum
end

puts increases
