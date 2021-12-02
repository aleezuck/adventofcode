file = File.read("input.txt")
input = file.split("\n")

position = 0
depth = 0
aim = 0

input.each do |string|
  directions = string.split
  
  case directions[0]
  when "forward"
    position += directions[1].to_i
    depth += directions[1].to_i * aim
  when "down"
    aim += directions[1].to_i
  when "up"
    aim -= directions[1].to_i
  end
end

puts position * depth
