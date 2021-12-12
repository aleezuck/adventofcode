file = File.read("input.txt")
input = file.split("\n").map { |x| x.chars.map { |y| y.to_i } }

def increase(octopi)
  new_octopi = octopi.map do |row|
    new_row = row.map { |num| num + 1 }
    new_row
  end

  return new_octopi
end

def flash(row, num, input)
  if row - 1 >= 0
    if num - 1 >= 0
      input[row-1][num-1] += 1 unless input[row-1][num-1] == 10
    end
    input[row-1][num] += 1 unless input[row-1][num] == 10
    if input[row-1][num+1]
      input[row-1][num+1] += 1 unless input[row-1][num+1] == 10
    end
  end

  if num - 1 >= 0
    input[row][num-1] += 1 unless input[row][num-1] == 10
  end
  if input[row][num+1]
    input[row][num+1] += 1 unless input[row][num+1] == 10
  end

  if input[row+1]
    if num - 1 >= 0
      if input[row+1][num-1]
        input[row+1][num-1] += 1 unless input[row+1][num-1] == 10
      end
    end
    if input[row+1][num]
      input[row+1][num] += 1 unless input[row+1][num] == 10
    end
    if input[row+1][num+1]
      input[row+1][num+1] += 1 unless input[row+1][num+1] == 10
    end
  end
end

step = 0
octopi = input.length * input[0].length

loop do
  new_input = increase(input)
  has_flashed = []
  flashes = 0
  
  loop do
    changed = 0
    new_input.each_with_index do |row, row_index|
      row.each_with_index do |num, num_index|
        if num == 10 && !has_flashed.include?([row_index, num_index])
          flash(row_index, num_index, new_input)
          flashes += 1
          changed += 1
          has_flashed << [row_index, num_index]
        end
      end
    end
    break if changed == 0
  end

  input = new_input.map! { |row| row.map! { |x| x == 10 ? 0 : x } }
  
  step += 1
  break if flashes == octopi
end

puts step
