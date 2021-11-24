file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

input << 0
input.sort!
input << input.last + 3

split_input = []
temp = []

input.each do |num|
  if temp.empty?
    temp << num
  elsif num - temp.last < 3
    temp << num
  else
    split_input << temp
    temp = [num]
  end
end

split_input << [input.last]

connections = split_input.map do |arr|
  # if 1 or 2 numbers, only 1 combination
  if arr.length == 1 || arr.length == 2
    1
  # if 3 numbers, can be [1, 2, 3] or [1, 3] -> 2 combinations
  elsif arr.length == 3
    2
  # if 4 numbers, can be [1, 2, 3, 4] or [1, 2, 4] or [1, 3, 4] or [1, 4] -> 4 combinations
  elsif arr.length == 4
    4
  # if 5 numbers, can be [1, 2, 3, 4, 5] or [1, 2, 3, 5] or [1, 2, 4, 5] or [1, 3, 4, 5] or [1, 2, 5] or [1, 3, 5] or [1, 4, 5]
  elsif arr.length == 5
    7
  else
    "ERROR"
  end
end

pp connections.reduce(:*)
