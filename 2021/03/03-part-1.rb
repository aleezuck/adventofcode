file = File.read("input.txt")
input = file.split("\n")

gamma_rate = ""
epsilon_rate = ""
chars = []
total = input.length

for i in (0...input[0].length)
  count = 0
  input.each do |string|
    count += 1 if string[i] == "1"
  end
  chars << count
end

chars.each do |char|
  if char > total - char
    gamma_rate << "1"
    epsilon_rate << "0"
  else
    gamma_rate << "0"
    epsilon_rate << "1"
  end
end

puts gamma_rate.to_i(2) * epsilon_rate.to_i(2)
