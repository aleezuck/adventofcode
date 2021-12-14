file = File.read("input.txt")
input = file.split("\n\n")

polymer = input[0]
rules = {}
input[1].split("\n").map { |x| x.split(" -> ") }.each do |arr|
  rules[arr[0]] = arr[1]
end

polymer_pairs = Hash.new(0)

polymer.chars.each_with_index do |char, index|
  next if index == 0
  pair = polymer[index-1] + char
  polymer_pairs[pair] += 1
end

40.times do
  new_pairs = polymer_pairs.dup

  polymer_pairs.each do |k, v|
    first = k[0] + rules[k]
    second = rules[k] + k[1]
    new_pairs[first] += v
    new_pairs[second] += v
    new_pairs[k] -= v
  end

  polymer_pairs = new_pairs
end

elements = Hash.new(0)

polymer_pairs.select { |k, v| v != 0 }.each do |k, v|
  elements[k[0]] += v
  elements[k[1]] += v
end

elements[polymer[0]] += 1
elements[polymer[-1]] += 1

sorted_elements = elements.values.sort

puts (sorted_elements[-1] - sorted_elements[0]) / 2
