file = File.read("input.txt")
input = file.split("\n").map { |x| x.split(" -> ").map{ |y| y.split(",").map{ |z| z.to_i } } }

straight_lines = input.select do |coords|
  coords[0][0] == coords[1][0] || coords[0][1] == coords[1][1]
end

x = straight_lines.flatten(1).minmax do |a, b|
  a[0] <=> b[0]
end
x_range = x[0][0]..x[1][0]
y = straight_lines.flatten(1).minmax do |a, b|
  a[1] <=> b[1]
end
y_range = y[0][1]..y[1][1]

arr = Array.new(x_range.last + 1) {Array.new(y_range.last + 1, 0) }

dups = 0

straight_lines.each do |line|
  if line[0][0] == line[1][0]
    x = line[0][0]
      if line[0][1] <= line[1][1]
        for y in line[0][1]..line[1][1]
          arr[x][y] += 1
        end
      else
        for y in line[1][1]..line[0][1]
          arr[x][y] += 1
        end
      end
  elsif line[0][1] == line[1][1]
    y = line[0][1]
    if line[0][0] <= line[1][0]
      for x in line[0][0]..line[1][0]
        arr[x][y] += 1
      end
    else
      for x in line[1][0]..line[0][0]
        arr[x][y] += 1
      end
    end
  end
end

dups = arr.flatten.select { |x| x > 1 }

puts dups.count
