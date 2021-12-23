file = File.read("input.txt")
input = file.split("\n")

directions = []

input.each do |string|
  hash = {}
  hash[:dir] = string.split(" ")[0]
  string.split(" ")[1].split(",").each do |substring|
    range = substring.split("=")[1].split("..").map { |x| x.to_i }
    hash[substring.split("=")[0]] = range
  end
  directions << hash
end

coords = Hash.new { |hash, key| Hash.new { |hash, key| Hash.new { |hash, key| "off" } } }

directions.each do |dir|
  x_hash = coords
  for x in dir["x"][0]..dir["x"][1]
    y_hash = coords[x]
    for y in dir["y"][0]..dir["y"][1]
      z_hash = coords[x][y]
      for z in dir["z"][0]..dir["z"][1]
        z_hash[z] = dir[:dir]
      end
      y_hash[y] = z_hash
    end
    x_hash[x] = y_hash
  end
end

active_cubes = 0

coords.each do |x, hash|
  hash.each do |y, row|
    row.each do |z, value|
      active_cubes += 1 if value == "on"
    end
  end
end

puts active_cubes

