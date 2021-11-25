file = File.read("input.txt")
input = file.split("\n")

x = 0
y = 0
# east = 0, south = 90, west = 180, north = 270
dir = 0

input.each do |string|
  nav = /(?<dir>[NSEWLRF])(?<val>\d{1,3})/.match(string)

  case nav[:dir]
  when "N"
    y += nav[:val].to_i
  when "E"
    x += nav[:val].to_i
  when "S"
    y -= nav[:val].to_i
  when "W"
    x -= nav[:val].to_i
  when "R"
    dir = (dir + nav[:val].to_i) % 360
  when "L"
    dir = (dir - nav[:val].to_i) % 360
  when "F"
    case dir
    when 270
      y += nav[:val].to_i
    when 0
      x += nav[:val].to_i
    when 90
      y -= nav[:val].to_i
    when 180
      x -= nav[:val].to_i
    end
  end
end

puts x.abs + y.abs
