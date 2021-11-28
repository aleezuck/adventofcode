file = File.read("input.txt")
input = file.split("\n")

# coords[z][y][x]
coords = Hash.new { |hash, key| Hash.new { |hash, key| Hash.new { |hash, key| "." } } }

# Initializing grid
x_y = Hash.new { |hash, key| Hash.new { |hash, key| "." } }

input.each_with_index do |row, row_index|
  y = Hash.new { |hash, key| "." }
  row.chars.each_with_index do |char, char_index|
    y[char_index] = char
  end
  x_y[row_index] = y
end

coords[0] = x_y

# Check how many active neighbours
def active_neighbours(coord_hash, z, y, x)
  neighbours = 0

  for dz in -1..1
    for dy in -1..1
      for dx in -1..1
        neighbours += 1 if coord_hash[z + dz][y + dy][x + dx] == "#"
      end
    end
  end

  neighbours -= 1 if coord_hash[z][y][x] == "#"

  return neighbours
end

# Check if cube changes state
def change_state?(coord_hash, z, y, x)
  change = false

  if coord_hash[z][y][x] == "#"
    change = true unless active_neighbours(coord_hash, z, y, x) == 2 || active_neighbours(coord_hash, z, y, x) == 3
  else
    change = true if active_neighbours(coord_hash, z, y, x) == 3
  end

  return change
end

# Check which cubes change their state
def which_coords_change(coord_hash)
  z_range = (coord_hash.keys.first-1)..(coord_hash.keys.last + 1)
  y_range = (coord_hash[0].keys.first-1)..(coord_hash[0].keys.last + 1)
  x_range = (coord_hash[0][0].keys.first-1)..(coord_hash[0][0].keys.last + 1)
  changed_coords = Hash.new { |hash, key| Hash.new { |hash, key| Hash.new { |hash, key| false } } }
  
  for z in z_range
    y_hash = Hash.new
    for y in y_range
      x_hash = Hash.new
      for x in x_range
        x_hash[x] = change_state?(coord_hash, z, y, x)
      end
      y_hash[y] = x_hash
    end
    changed_coords[z] = y_hash
  end

  return changed_coords
end

6.times do
# Create new hash with changed states
changed = which_coords_change(coords)
new_coords = Hash.new { |hash, key| Hash.new { |hash, key| Hash.new { |hash, key| "." } } }

changed.each do |z, y_x|
  y_x_hash = Hash.new { |hash, key| Hash.new { |hash, key| "." } }
  y_x.each do |y, x|
    x_hash = Hash.new { |hash, key| "." }
    x.each do |key, value|
      if value
        if coords[z][y][key] == "."
          x_hash[key] = "#"
        elsif coords[z][y][key] == "#"
          x_hash[key] = "."
        end
      else
        x_hash[key] = coords[z][y][key]
      end
    end
    y_x_hash[y] = x_hash
  end
  new_coords[z] = y_x_hash
end

coords = new_coords
end

active_cubes = 0

coords.each do |z, hash|
  hash.each do |y, row|
    row.each do |x, value|
      active_cubes += 1 if value == "#"
    end
  end
end

puts active_cubes
