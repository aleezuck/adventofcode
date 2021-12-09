file = File.read("input.txt")
input = file.split("\n").map { |x| x.split(" | ") }

output = []

input.each do |arr|
  output << arr[1].split(" ")
end

unique = output.flatten.select { |x| [2, 3, 4, 7].include?(x.length) }

puts unique.count
