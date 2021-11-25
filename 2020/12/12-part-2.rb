file = File.read("input.txt")
input = file.split("\n")

x = 0
y = 0

way_x = 10
way_y = 1

input.each do |string|
  nav = /(?<dir>[NSEWLRF])(?<val>\d{1,3})/.match(string)

  case nav[:dir]
  when "N"
    way_y += nav[:val].to_i
  when "E"
    way_x += nav[:val].to_i
  when "S"
    way_y -= nav[:val].to_i
  when "W"
    way_x -= nav[:val].to_i
  when "R"
    case nav[:val].to_i
    when 90
      temp = way_x
      way_x = way_y
      way_y = -temp
    when 180
      way_x = -way_x
      way_y = -way_y
    when 270
      temp = way_x
      way_x = -way_y
      way_y = temp
    end
  when "L"
    case nav[:val].to_i
    when 90
      temp = way_x
      way_x = -way_y
      way_y = temp
    when 180
      way_x = -way_x
      way_y = -way_y
    when 270
      temp = way_x
      way_x = way_y
      way_y = -temp
    end
  when "F"
    x += way_x * nav[:val].to_i
    y += way_y * nav[:val].to_i
  end
end

puts x.abs + y.abs
