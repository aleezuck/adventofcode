file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

preamble = 25

for i in preamble..input.length
  number = input[i]
  combinations = input[i-preamble..i-1].combination(2).to_a.map { |arr| arr.sum }
  break unless combinations.include?(number)
end

puts number
