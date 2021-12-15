file = File.read("input.txt")
input = file.split("\n").map { |x| x.chars.map { |y| y.to_i } }

input.each do |row|
  length = row.length
  4.times do
    row[-length..-1].each do |num|
      if num == 8
        row << 9
      else
        row << (num + 1) % 9
      end
    end
  end
end

def inc_risk(arr)
  new_arr = arr.map do |row|
    row.map do |num|
      if num == 8
        9
      else
        (num + 1) % 9
      end
    end
  end
  return new_arr
end

new_arr = input

4.times do
  new_arr = inc_risk(new_arr)
  new_arr.each do |row|
    input << row
  end
end

x = input[0].length
y = input[1].length

distance_row = []
x.times { distance_row << 1_000_000 }
distances = []
y.times { distances << distance_row.dup }
distances[0][0] = 0

2.times do
for current_y in 0..(y-1)
  for current_x in 0..(x-1)
    unless current_x + 1 == x
      distance_right = input[current_y][current_x+1] + distances[current_y][current_x]

      if distance_right < distances[current_y][current_x+1]
        distances[current_y][current_x+1] = distance_right
      end
    end

    unless current_x - 1 < 0
      distance_left = input[current_y][current_x-1] + distances[current_y][current_x]

      if distance_left < distances[current_y][current_x-1]
        distances[current_y][current_x-1] = distance_left
      end
    end

    unless current_y + 1 == y
      distance_down = input[current_y+1][current_x] + distances[current_y][current_x]

      if distance_down < distances[current_y+1][current_x]
        distances[current_y+1][current_x] = distance_down
      end
    end

    unless current_y - 1 < 0
      distance_up = input[current_y-1][current_x] + distances[current_y][current_x]

      if distance_up < distances[current_y-1][current_x]
        distances[current_y-1][current_x] = distance_up
      end
    end
  end
end
end

puts distances[-1][-1]