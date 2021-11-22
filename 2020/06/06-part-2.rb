file = File.read("input.txt")
input = file.split("\n\n")

sum = 0

input.each do |group|
  answer_hash = Hash.new(0)
  people = group.split(" ").length

  group.split(" ").each do |person|
    person.chars.each do |letter|
      answer_hash[letter] += 1
    end
  end

  # take all the hash values that equal the number of people in the group (everyone answered)
  sum += answer_hash.values.select { |x| x == people }.count
end

puts sum
