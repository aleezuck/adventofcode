file = File.read("input.txt")
input = file.split("\n\n")

algorithm = input[0].chars

image = input[1].split("\n").map { |x| x.chars }

def add_border(image, char)
  new_image = []
  cols = image[0].count + 4
  2.times { new_image << Array.new(cols, char) }
  image.each do |row|
    new_image << [char, char, row, char, char].flatten
  end
  2.times { new_image << Array.new(cols, char) }
  return new_image
end

i = 1

50.times do
  if i.even? && algorithm[0] == "#"
    new_image = add_border(image, "#")
  else
    new_image = add_border(image, ".")
  end

  output_pixels = {}

  for row in 1..new_image.length-2
    for col in 1..new_image[0].length-2
      pixels = []
      pixels << new_image[row-1][(col-1..col+1)]
      pixels << new_image[row][(col-1..col+1)]
      pixels << new_image[row+1][(col-1..col+1)]

      string = pixels.flatten.join
      string.gsub!(".", "0")
      string.gsub!("#", "1")
      char = algorithm[string.to_i(2)]
      output_pixels[[row, col]] = char
    end
  end

  output_pixels.each do |k, v|
    new_image[k[0]][k[1]] = v
  end

  # odd steps only
  if i.odd? && algorithm[0] == "#"
    new_image[0].map! do |char|
      "#"
    end
    new_image[-1].map! do |char|
      "#"
    end
    new_image.each do |row|
      row[0] = "#"
      row[-1] = "#"
    end
  end

  # even steps only
  if i.even? && algorithm[0] == "#"
    new_image[0].map! do |char|
      "."
    end
    new_image[-1].map! do |char|
      "."
    end
    new_image.each do |row|
      row[0] = "."
      row[-1] = "."
    end
  end

  image = new_image

  i += 1
end

count = 0

image.each do |row|
  row.each do |char|
    count += 1 if char == "#"
  end
end

puts count
