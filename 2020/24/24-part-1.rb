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

puts tiles_hash.select { |k, v| v % 2 == 1 }.count
