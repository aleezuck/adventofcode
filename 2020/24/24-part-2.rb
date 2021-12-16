file = File.read("input.txt")
input = file.split("\n")

input.map! do |row|
  parsed_row = []
  until row.empty?
    if row.start_with?("se") || row.start_with?("sw") || row.start_with?("nw") || row.start_with?("ne")
      parsed_row << row.slice!(0..1)
    else
      parsed_row << row.slice!(0)
    end
  end

  parsed_row
end

tiles_hash = Hash.new(0)

input.each do |row|
  x = 0
  y = 0
  
  row.each do |dir|
    case dir
    when "e" then x += 1
    when "w" then x -= 1
    when "ne" then y += 1
    when "sw" then y -= 1
    when "se"
      x += 1
      y -= 1
    when "nw"
      x -= 1
      y += 1      
    end
  end

  tiles_hash[[x, y]] += 1
end

100.times do

  x_range = (tiles_hash.keys.min_by { |arr| arr[0] }[0] - 1)..(tiles_hash.keys.max_by { |arr| arr[0] }[0] + 1)
  y_range = (tiles_hash.keys.min_by { |arr| arr[1] }[1] - 1)..(tiles_hash.keys.max_by { |arr| arr[1] }[1] + 1)

  flipped_tiles = Hash.new

  for x in x_range
    for y in y_range
      black = 0

      # east
      black += 1 if tiles_hash[[x+1, y]] % 2 == 1
      # west
      black += 1 if tiles_hash[[x-1, y]] % 2 == 1
      # northeast
      black += 1 if tiles_hash[[x, y+1]] % 2 == 1
      # southwest
      black += 1 if tiles_hash[[x, y-1]] % 2 == 1
      # southeast
      black += 1 if tiles_hash[[x+1, y-1]] % 2 == 1
      # northwest
      black += 1 if tiles_hash[[x-1, y+1]] % 2 == 1

      if tiles_hash[[x, y]] % 2 == 1
        flipped_tiles[[x, y]] = true unless black == 1 || black == 2
      else
        flipped_tiles[[x, y]] = true if black == 2
      end
    end
  end

  flipped_tiles.keys.each do |key|
    tiles_hash[key] += 1
  end

end

puts tiles_hash.select { |k, v| v % 2 == 1 }.count
