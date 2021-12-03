file = File.read("input.txt")
input = file.split("\n")

oxygen = input.dup
co2 = input.dup

for i in (0...input[0].length)
  count = 0
  total = oxygen.length
  oxygen.each do |string|
    count += 1 if string[i] == "1"
  end
  if count >= total - count
    oxygen.select! { |string| string[i] == "1" }
  else
    oxygen.select! { |string| string[i] == "0" }
  end
  break if oxygen.length == 1
end

for i in (0...input[0].length)
  count = 0
  total = co2.length
  co2.each do |string|
    count += 1 if string[i] == "1"
  end
  if count >= total - count
    co2.select! { |string| string[i] == "0" }
  else
    co2.select! { |string| string[i] == "1" }
  end
  break if co2.length == 1
end

puts oxygen[0].to_i(2) * co2[0].to_i(2)
