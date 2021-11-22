file = File.read("input.txt")
input = file.split("\n\n")

sum = 0

input.each do |group|
  answer_hash = {}

  group.split(" ").each do |person|
    person.chars.each do |letter|
      answer_hash[letter] = true
    end
  end

  sum += answer_hash.count
end

puts sum
