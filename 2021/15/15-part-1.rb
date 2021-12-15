file = File.read("input.txt")
input = file.split("\n").map { |x| x.chars.map { |y| y.to_i } }

x = input[0].length
y = input[1].length

distance_row = []
x.times { distance_row << 1_000_000 }
distances = []
y.times { distances << distance_row.dup }
distances[0][0] = 0

for current_y in 0..(y-1)
  for current_x in 0..(x-1)
    unless current_x + 1 == x
      distance_right = input[current_y][current_x+1] + distances[current_y][current_x]

      if distance_right < distances[current_y][current_x+1]
        distances[current_y][current_x+1] = distance_right
      end
    end

    unless current_y + 1 == y
      distance_down = input[current_y+1][current_x] + distances[current_y][current_x]

      if distance_down < distances[current_y+1][current_x]
        distances[current_y+1][current_x] = distance_down
      end
    end
  end
end

puts distances[-1][-1]