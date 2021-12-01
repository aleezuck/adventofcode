file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

increases = 0

input.each_with_index do |num, index|
  next if index == 0
  increases += 1 if num > input[index-1]
end

puts increases
