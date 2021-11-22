file = File.read("input.txt")
input = file.split("\n")

def get_seat(string)
  # Starting bounds of whole plane
  row_lower = 0
  row_upper = 127
  col_lower = 0
  col_upper = 7
  
  string.chars.each do |char|
    case char
    when "F"
      half = (row_upper - row_lower + 1) / 2
      row_upper -= half
    when "B"
      half = (row_upper - row_lower + 1) / 2
      row_lower += half
    when "R"
      half = (col_upper - col_lower + 1) / 2
      col_lower += half
    when "L"
      half = (col_upper - col_lower + 1) / 2
      col_upper -= half
    end
  end

  return row_lower * 8 + col_lower
end

seat_ids = input.map { |i| get_seat(i) }

seat_ids.sort.each do |seat|
  unless seat_ids.include?(seat + 1)
    puts "Your seat id is: #{seat + 1}"
    break
  end
end
