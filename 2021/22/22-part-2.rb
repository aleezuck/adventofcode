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

coords = [ { "x" => directions[0]["x"], "y" => directions[0]["y"], "z" => directions[0]["z"] } ]

def overlap?(arr1, arr2)
  (arr1[0]..arr1[1]).include?(arr2[0]) || (arr2[0]..arr2[1]).include?(arr1[0])
end

def intersection(hash1, hash2)
  hash = {
    "x" => [[hash1["x"][0], hash2["x"][0]].max, [hash1["x"][1], hash2["x"][1]].min],
    "y" => [[hash1["y"][0], hash2["y"][0]].max, [hash1["y"][1], hash2["y"][1]].min],
    "z" => [[hash1["z"][0], hash2["z"][0]].max, [hash1["z"][1], hash2["z"][1]].min]
  }
  return hash
end

def union(hash1, hash2, intersection)
  hashes = []
  x = [hash1["x"][0], hash2["x"][0], hash1["x"][1], hash2["x"][1]].sort
  y = [hash1["y"][0], hash2["y"][0], hash1["y"][1], hash2["y"][1]].sort
  z = [hash1["z"][0], hash2["z"][0], hash1["z"][1], hash2["z"][1]].sort

  hashes << { "x" => [x[0], x[1]-1], "y" => [y[0], y[1]-1], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[0], x[1]-1], "y" => [y[0], y[1]-1], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[0], x[1]-1], "y" => [y[0], y[1]-1], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[0], x[1]-1], "y" => [y[1], y[2]], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[0], x[1]-1], "y" => [y[1], y[2]], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[0], x[1]-1], "y" => [y[1], y[2]], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[0], x[1]-1], "y" => [y[2] + 1, y[3]], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[0], x[1]-1], "y" => [y[2] + 1, y[3]], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[0], x[1]-1], "y" => [y[2] + 1, y[3]], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[1], x[2]], "y" => [y[0], y[1]-1], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[1], x[2]], "y" => [y[0], y[1]-1], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[1], x[2]], "y" => [y[0], y[1]-1], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[1], x[2]], "y" => [y[1], y[2]], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[1], x[2]], "y" => [y[1], y[2]], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[1], x[2]], "y" => [y[2] + 1, y[3]], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[1], x[2]], "y" => [y[2] + 1, y[3]], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[1], x[2]], "y" => [y[2] + 1, y[3]], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[0], y[1]-1], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[0], y[1]-1], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[0], y[1]-1], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[1], y[2]], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[1], y[2]], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[1], y[2]], "z" => [z[2] + 1, z[3]] }

  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[2] + 1, y[3]], "z" => [z[0], z[1]-1] }
  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[2] + 1, y[3]], "z" => [z[1], z[2]] }
  hashes << { "x" => [x[2] + 1, x[3]], "y" => [y[2] + 1, y[3]], "z" => [z[2] + 1, z[3]] }

  hashes.select! do |hash|
    (overlap?(hash["x"], hash1["x"]) && overlap?(hash["y"], hash1["y"]) && overlap?(hash["z"], hash1["z"])) || (overlap?(hash["x"], hash2["x"]) && overlap?(hash["y"], hash2["y"]) && overlap?(hash["z"], hash2["z"]))
  end

  hashes.select! do |hash|
    hash["x"][0] <= hash["x"][1] && hash["y"][0] <= hash["y"][1] && hash["z"][0] <= hash["z"][1]
  end

  return hashes
end

i = 0
directions.each_with_index do |dir, index|
  i += 1
  puts "#{i}..."
  next if index == 0

  new_coords = { "x" => dir["x"], "y" => dir["y"], "z" => dir["z"] }

  coords.each_with_index do |coord_hash, index|
    if overlap?(new_coords["x"], coord_hash["x"]) && overlap?(new_coords["y"], coord_hash["y"]) && overlap?(new_coords["z"], coord_hash["z"])
      remaining = []
      intersection = intersection(new_coords, coord_hash)
      possibilities = union(new_coords, coord_hash, intersection)
      possibilities.each do |p|
        remaining << p if overlap?(p["x"], coord_hash["x"]) && overlap?(p["y"], coord_hash["y"]) && overlap?(p["z"], coord_hash["z"])
      end
      coords[index] = remaining
    end
  end

  if dir[:dir] == "on"
    coords << new_coords
  end

  coords.flatten!
  coords.uniq!
end

cubes = 0

coords.each do |c|
  cubes += (c["x"][1] - c["x"][0] + 1) * (c["y"][1] - c["y"][0] + 1) * (c["z"][1] - c["z"][0] + 1)
end

puts cubes