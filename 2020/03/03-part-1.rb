file = File.read("input.txt")
input = file.split("\n")

index = 0
trees = 0
row_length = input.first.length

input.each do |row|
  trees += 1 if row[index % row_length] == "#"
  index += 3
end

puts trees
