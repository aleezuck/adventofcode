file = File.read("input.txt")
input = file.split("\n\n")

polymer = input[0]
rules = {}
input[1].split("\n").map { |x| x.split(" -> ") }.each do |arr|
  rules[arr[0]] = arr[1]
end

10.times do

  insertions = []

  polymer.chars.each_with_index do |char, index|
    next if index == 0
    pair = polymer[index-1] + polymer[index]
    insertions << rules[pair]
  end

  new_polymer = polymer.chars.zip(insertions).flatten.join

  polymer = new_polymer

end

elements = polymer.chars.tally.values.sort

puts elements[-1] - elements[0]
