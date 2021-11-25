file = File.read("input.txt")
input = file.split("\n")
input.map! { |arr| arr.chars }

seating_change = Array.new(input.length) { Array.new(input.first.length) }

# count adjacent filled seats
def adj_seats(row_index, col_index, seat_array)
  seats = 0

  if row_index - 1 >= 0
  # top left
    if col_index - 1 >= 0
      seats += 1 if seat_array[row_index - 1][col_index - 1] == "#"
    end
  # top middle
    seats += 1 if seat_array[row_index - 1][col_index] == "#"
  # top right
    seats += 1 if seat_array[row_index - 1][col_index + 1] == "#"
  end

  # middle left
  if col_index - 1 >= 0
    seats += 1 if seat_array[row_index][col_index - 1] == "#"
  end
  # middle right
  seats += 1 if seat_array[row_index][col_index + 1] == "#"

  # bottom left
  if row_index + 1 < seat_array.length
    if col_index - 1 >= 0
      seats += 1 if seat_array[row_index + 1][col_index - 1] == "#"
    end
  # bottom middle
    seats += 1 if seat_array[row_index + 1][col_index] == "#"
  # bottom right
    seats += 1 if seat_array[row_index + 1][col_index + 1] == "#"
  end

  return seats
end

loop do
  # loop through input and see what seats need to change
  changed_seats = 0
  input.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      if cell == "L" && adj_seats(row_index, col_index, input) == 0
        seating_change[row_index][col_index] = true
        changed_seats += 1
      elsif cell == "#" && adj_seats(row_index, col_index, input) >= 4
        seating_change[row_index][col_index] = true
        changed_seats += 1
      else
        seating_change[row_index][col_index] = false
      end
    end
  end

  # if no seats need to change
  break if changed_seats == 0

  # loop through input again and change seats if necessary
  input.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      if seating_change[row_index][col_index]
        if input[row_index][col_index] == "#"
          input[row_index][col_index] = "L"
        elsif input[row_index][col_index] = "L"
          input[row_index][col_index] = "#"
        end
      end
    end
  end
end

# count all occupied seats
occ_seat = 0

input.each do |arr|
  occ_seat += arr.count("#")
end

puts occ_seat
