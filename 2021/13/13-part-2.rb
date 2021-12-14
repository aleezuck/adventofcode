file = File.read("input.txt")
input = file.split("\n\n")

coords = input[0].split("\n").map { |x| x.split(",").map {|y| y.to_i } }
folds = input[1].split("\n").map do |string|
  info = /(\w)=(\d+)/.match(string)
  [info[1], info[2].to_i]
end

x_max = 0
y_max = 0

coords.each do |coord|
  x_max = coord[0] if coord[0] > x_max
  y_max = coord[1] if coord[1] > y_max
end

coords_map = Array.new(y_max+1) { Array.new(x_max+1) { "." } }

coords.each do |coord|
  x = coord[0]
  y = coord[1]

  coords_map[y][x] = "#"
end

def fold(coords_map, dir, val)
  if dir == "y"
    new_map = coords_map[0..(val-1)]

    j = val - 1

    for i in ((val+1)..(coords_map.length-1))
      coords_map[i].each_with_index do |x, x_index|
        if x == "#"
          new_map[j][x_index] = "#"
        end
      end
      j -= 1
    end
  elsif dir == "x"
    new_map = []
    coords_map.each do |arr|
      new_map << arr[0..(val-1)]
    end

    j = val - 1

    for i in ((val+1)..(coords_map[0].length-1))
      coords_map.each_with_index do |y, y_index|
        if y[i] == "#"
          new_map[y_index][j] = "#"
        end
      end
      j -= 1
    end
  end

  return new_map
end

folds.each do |fold|
  folded_map = fold(coords_map, fold[0], fold[1])
  coords_map = folded_map
end

pp coords_map.map { |x| x.join }
