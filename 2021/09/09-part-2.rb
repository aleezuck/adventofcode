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

basins = []

for y in y_range
  for x in x_range
    val = map[y][x]
    if val < map[y+1][x] && val < map[y-1][x] && val < map[y][x+1] && val < map[y][x-1]
      hash = { x: x, y: y }
      basins << hash
    end
  end
end

basins.each do |hash|
  points = []
  points << [hash[:x], hash[:y]]
  
  points.each do |point|
    x = point[0]
    y = point[1]
    val = map[y][x]

    pos_x = x + 1
    until map[y][pos_x] <= val || map[y][pos_x] == 9 || map[y][pos_x] == 10
      points << [pos_x, y]
      pos_x += 1
    end

    neg_x = x - 1
    until map[y][neg_x] <= val || map[y][neg_x] == 9 || map[y][neg_x] == 10
      points << [neg_x, y]
      neg_x -= 1
    end

    pos_y = y + 1
    until map[pos_y][x] <= val || map[pos_y][x] == 9 || map[pos_y][x] == 10
      points << [x, pos_y]
      pos_y += 1
    end

    neg_y = y - 1
    until map[neg_y][x] <= val || map[neg_y][x] == 9 || map[neg_y][x] == 10
      points << [x, neg_y]
      neg_y -= 1
    end
  end

  hash[:area] = points.uniq.count
end

area = 1

basins.sort_by { |k| k[:area] }.reverse.first(3).each { |k, v| area *= k[:area] }

puts area
