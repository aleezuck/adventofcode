file = File.read("input.txt")
input = file.split("\n").map { |x| x.split(" ") }

valid_passwords = 0

input.each do |arr|
  range = arr[0].split("-").map { |x| x.to_i }
  letter = arr[1][0]
  count = arr[2].count(letter)
  valid_passwords +=1 if (range[0]..range[1]).include?(count)
end

puts valid_passwords
