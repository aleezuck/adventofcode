file = File.read("input.txt")
input = file.split("\n")

blank_row = Array.new(input[0].length+2, 10)

map = []
map << blank_row

input.each do |string|
  row = string.chars.map { |x| x.to_i }
  row.unshift(10)
  row << 10
  map << row
end

map << blank_row

x_range = 1..(map[0].length-2)
y_range = 1..(map.length-2)

risk = 0

for y in y_range
  for x in x_range
    val = map[y][x]
    if val < map[y+1][x] && val < map[y-1][x] && val < map[y][x+1] && val < map[y][x-1]
      risk += (val + 1)
    end
  end
end

puts risk