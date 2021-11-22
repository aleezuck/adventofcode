file = File.read("input.txt")
input = file.split("\n").map { |x| x.split(" ") }

valid_passwords = 0

input.each do |arr|
  pos = arr[0].split("-").map { |x| x.to_i - 1 }
  letter = arr[1][0]
  
  count = 0
  count += 1 if arr[2][pos[0]] == letter
  count += 1 if arr[2][pos[1]] == letter
  valid_passwords += 1 if count == 1
end

puts valid_passwords
