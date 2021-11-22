file = File.read("input.txt")
input = file.split("\n")

def count_trees(right, down, input)
  index = 0
  row = 0
  trees = 0
  row_length = input.first.length

  input.each do |input_row|
    if row % down == 0
      trees += 1 if input_row[index % row_length] == "#"
      index += right
    end
    
    row += 1
  end

  return trees
end

puts count_trees(1, 1, input) * count_trees(3, 1, input) * count_trees(5, 1, input) * count_trees(7, 1, input) * count_trees(1, 2, input)
