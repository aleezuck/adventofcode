file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

input << 0
input.sort!

one_jolt = 0
two_jolt = 0
three_jolt = 0

input.each do |i|
  if input.include?(i + 1)
    one_jolt += 1
  elsif input.include?(i + 2)
    two_jolt += 1
  else
    three_jolt += 1
  end
end

puts one_jolt * three_jolt
