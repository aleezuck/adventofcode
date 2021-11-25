file = File.read("input.txt")
input = file.split("\n")
input.map! { |arr| arr.chars }

seating_change = Array.new(input.length) { Array.new(input.first.length) }

# count adjacent filled seats
def adj_seats(row_index, col_index, seat_array)
  seats = 0

  # top left
  col_counter = col_index - 1
  row_counter = row_index- 1
  see_seat = false

  until row_counter < 0 || col_counter < 0
    if seat_array[row_counter][col_counter] == "#"
      see_seat = true
      break
    elsif seat_array[row_counter][col_counter] == "L"
      break
    else
      row_counter -= 1
      col_counter -= 1
    end
  end
  seats +=1 if see_seat

  # top middle
  row_counter = row_index - 1
  see_seat = false

  until row_counter < 0
    if seat_array[row_counter][col_index] == "#"
      see_seat = true
      break
    elsif seat_array[row_counter][col_index] == "L"
      break
    else
      row_counter -= 1
    end
  end
  seats +=1 if see_seat

  # top right
  col_counter = col_index + 1
  row_counter = row_index - 1
  see_seat = false

  until row_counter < 0 || col_counter >= seat_array.first.length
    if seat_array[row_counter][col_counter] == "#"
      see_seat = true
      break
    elsif seat_array[row_counter][col_counter] == "L"
      break
    else
      row_counter -= 1
      col_counter += 1
    end
  end
  seats +=1 if see_seat

  # middle left
  col_counter = col_index - 1
  see_seat = false

  until col_counter < 0
    if seat_array[row_index][col_counter] == "#"
      see_seat = true
      break
    elsif seat_array[row_index][col_counter] == "L"
      break
    else
      col_counter -= 1
    end
  end
  seats +=1 if see_seat

  # middle right
  col_counter = col_index + 1
  see_seat = false

  until col_counter >= seat_array.first.length
    if seat_array[row_index][col_counter] == "#"
      see_seat = true
      break
    elsif seat_array[row_index][col_counter] == "L"
      break
    else
      col_counter += 1
    end
  end
  seats +=1 if see_seat

  # bottom left
  col_counter = col_index - 1
  row_counter = row_index + 1
  see_seat = false

  until row_counter >= seat_array.length || col_counter < 0
    if seat_array[row_counter][col_counter] == "#"
      see_seat = true
      break
    elsif seat_array[row_counter][col_counter] == "L"
      break
    else
      row_counter += 1
      col_counter -= 1
    end
  end
  seats +=1 if see_seat

  # bottom middle
  row_counter = row_index + 1
  see_seat = false

  until row_counter >= seat_array.length
    if seat_array[row_counter][col_index] == "#"
      see_seat = true
      break
    elsif seat_array[row_counter][col_index] == "L"
      break
    else
      row_counter += 1
    end
  end
  seats +=1 if see_seat

  # bottom right
  col_counter = col_index + 1
  row_counter = row_index + 1
  see_seat = false

  until row_counter >= seat_array.length || col_counter >= seat_array.first.length
    if seat_array[row_counter][col_counter] == "#"
      see_seat = true
      break
    elsif seat_array[row_counter][col_counter] == "L"
      break
    else
      row_counter += 1
      col_counter += 1
    end
  end
  seats +=1 if see_seat

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
      elsif cell == "#" && adj_seats(row_index, col_index, input) >= 5
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
